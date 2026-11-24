import { createHmac, timingSafeEqual } from "node:crypto";
import { GraphQLError } from "graphql";
import { config } from "../config";
import {
  TOKEN_EXPIRATION_ENABLED,
  TOKEN_EXPIRATION_HOURS,
} from "./util";

const TOKEN_ISSUER = "webservermusicover";

export type AuthenticatedUser = {
  id: number;
  name: string;
  role: "User" | "Admin";
};

export type AuthContext = {
  user: AuthenticatedUser | null;
};

function getJwtSecret(): string {
  const secret = config.jwtSecret;
  if (!secret || Buffer.byteLength(secret, "utf8") < 32) {
    throw new Error("JWT_SECRET must be configured with at least 32 bytes");
  }
  return secret;
}

function encodeJson(value: object): string {
  return Buffer.from(JSON.stringify(value)).toString("base64url");
}

function decodeJson(segment: string): unknown {
  try {
    return JSON.parse(Buffer.from(segment, "base64url").toString("utf8"));
  } catch {
    return null;
  }
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

export function createAuthToken(user: AuthenticatedUser): string {
  const now = Math.floor(Date.now() / 1000);
  const header = encodeJson({ alg: "HS256", typ: "JWT" });
  const payload = encodeJson({
    sub: String(user.id),
    name: user.name,
    role: user.role,
    iss: TOKEN_ISSUER,
    iat: now,
    ...(TOKEN_EXPIRATION_ENABLED
      ? { exp: now + TOKEN_EXPIRATION_HOURS * 60 * 60 }
      : {}),
  });
  const signingInput = `${header}.${payload}`;
  const signature = createHmac("sha256", getJwtSecret())
    .update(signingInput)
    .digest("base64url");

  return `${signingInput}.${signature}`;
}

function verifyAuthToken(token: string): AuthenticatedUser | null {
  if (token.length > 8192) {
    return null;
  }

  const parts = token.split(".");
  if (parts.length !== 3 || parts.some((part) => !part)) {
    return null;
  }

  const [encodedHeader, encodedPayload, encodedSignature] = parts;
  const header = decodeJson(encodedHeader);
  if (
    !isRecord(header) ||
    header.alg !== "HS256" ||
    header.typ !== "JWT"
  ) {
    return null;
  }

  const expectedSignature = createHmac("sha256", getJwtSecret())
    .update(`${encodedHeader}.${encodedPayload}`)
    .digest();
  let actualSignature: Buffer;
  try {
    actualSignature = Buffer.from(encodedSignature, "base64url");
  } catch {
    return null;
  }

  if (
    actualSignature.length !== expectedSignature.length ||
    !timingSafeEqual(actualSignature, expectedSignature)
  ) {
    return null;
  }

  const payload = decodeJson(encodedPayload);
  const now = Math.floor(Date.now() / 1000);
  if (
    !isRecord(payload) ||
    payload.iss !== TOKEN_ISSUER ||
    typeof payload.sub !== "string" ||
    !/^[1-9]\d*$/.test(payload.sub) ||
    !Number.isSafeInteger(Number(payload.sub)) ||
    typeof payload.name !== "string" ||
    (payload.role !== "User" && payload.role !== "Admin") ||
    typeof payload.iat !== "number" ||
    !Number.isInteger(payload.iat) ||
    payload.iat > now
  ) {
    return null;
  }

  if (
    TOKEN_EXPIRATION_ENABLED &&
    (typeof payload.exp !== "number" ||
      !Number.isInteger(payload.exp) ||
      payload.exp <= now)
  ) {
    return null;
  }

  return {
    id: Number(payload.sub),
    name: payload.name,
    role: payload.role,
  };
}

export function getRequestUser(
  authorization: string | undefined
): AuthenticatedUser | null {
  if (authorization === undefined) {
    return null;
  }

  const [scheme, token, extra] = authorization.trim().split(/\s+/);
  if (
    scheme?.toLowerCase() !== "bearer" ||
    !token ||
    extra !== undefined
  ) {
    throw new GraphQLError("Invalid authorization header", {
      extensions: { code: "UNAUTHENTICATED" },
    });
  }

  const user = verifyAuthToken(token);
  if (!user) {
    throw new GraphQLError("Invalid or expired token", {
      extensions: { code: "UNAUTHENTICATED" },
    });
  }
  return user;
}

export function requireAuthenticatedUser(
  context: AuthContext
): AuthenticatedUser {
  if (!context.user) {
    throw new GraphQLError("Authentication required", {
      extensions: { code: "UNAUTHENTICATED" },
    });
  }
  return context.user;
}

export function requireAdmin(context: AuthContext): AuthenticatedUser {
  const user = requireAuthenticatedUser(context);
  if (user.role !== "Admin") {
    throw new GraphQLError("Administrator access required", {
      extensions: { code: "FORBIDDEN" },
    });
  }
  return user;
}
