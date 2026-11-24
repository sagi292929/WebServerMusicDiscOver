import { prisma } from "../database";
import {
  type AuthContext,
  createAuthToken,
  requireAdmin,
  requireAuthenticatedUser,
} from "./auth";
import { hashPassword, verifyPassword } from "./util";

export const userResolvers = {
  Query: {
    getUser: async (
      _: unknown,
      { id }: { id: number },
      context: AuthContext
    ) => {
      const currentUser = requireAuthenticatedUser(context);
      if (currentUser.id !== id && currentUser.role !== "Admin") {
        requireAdmin(context);
      }

      return prisma.user.findUnique({
        where: { Id: id },
        select: { Id: true, name: true, role: true },
      });
    },
    getUsers: async (_: unknown, _args: unknown, context: AuthContext) => {
      requireAdmin(context);
      return prisma.user.findMany({
        select: { Id: true, name: true, role: true },
        orderBy: { Id: "asc" },
      });
    },
    userExists: async (
      _: unknown,
      { name }: { name: string },
      context: AuthContext
    ) => {
      requireAdmin(context);
      return (await prisma.user.findFirst({
        where: { name },
        select: { Id: true },
      })) !== null;
    },
  },
  Mutation: {
    saveUser: async (
      _: unknown,
      { name, password }: { name: string; password: string },
      context: AuthContext
    ) => {
      return prisma.$transaction(async (transaction) => {
        const existingUser = await transaction.user.findFirst({
          where: { name },
          select: { Id: true },
          orderBy: { Id: "asc" },
        });

        if (existingUser) {
          const currentUser = requireAuthenticatedUser(context);
          if (
            currentUser.id !== existingUser.Id &&
            currentUser.role !== "Admin"
          ) {
            requireAdmin(context);
          }

          const hashedPassword = await hashPassword(password);
          return transaction.user.update({
            where: { Id: existingUser.Id },
            data: { name, password: hashedPassword },
            select: { Id: true, name: true, role: true },
          });
        }

        const hashedPassword = await hashPassword(password);
        return transaction.user.create({
          data: { name, password: hashedPassword, role: "User" },
          select: { Id: true, name: true, role: true },
        });
      });
    },
    login: async (
      _: unknown,
      { name, password }: { name: string; password: string }
    ) => {
      const user = await prisma.user.findFirst({
        where: { name },
        select: { Id: true, name: true, role: true, password: true },
      });

      if (!user || !(await verifyPassword(password, user.password))) {
        return null;
      }

      if (user.role !== "User" && user.role !== "Admin") {
        throw new Error("User has an unsupported role");
      }

      return createAuthToken({
        id: user.Id,
        name: user.name,
        role: user.role,
      });
    },
  },
};
