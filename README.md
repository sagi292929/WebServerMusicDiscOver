# Music DiscOver Server

A TypeScript GraphQL API for discovering music. The server combines Elasticsearch search data with relational data stored in SQLite through Prisma.

## Stack

- Node.js and TypeScript
- Express 5
- Apollo Server 5
- GraphQL
- Prisma 7
- SQLite
- Elasticsearch

## Development

Install dependencies:

```sh
npm install
```

Create a local environment file:

```sh
cp .env.example .env
```

Update `.env` before starting the server. `JWT_SECRET` must contain at least 32 bytes. Then start Elasticsearch locally and run:

```sh
npm run dev
```

The GraphQL endpoint is available at `http://localhost:4000/graphql` by default.

Useful commands:

```sh
npm run dev
npm run build
npm start
```

`npm start` runs the compiled server from `dist/`. Build it first with `npm run build`.

## Environment

| Variable | Default | Purpose |
| --- | --- | --- |
| `PORT` | `4000` | HTTP server port |
| `DATABASE_URL` | `file:./dev.db` | SQLite database location |
| `JWT_SECRET` | none | Required secret used to sign and verify JWT bearer tokens |
| `ELASTICSEARCH_NODE` | `http://localhost:9200` | Elasticsearch endpoint |
| `ELASTICSEARCH_USERNAME` | none | Optional Elasticsearch basic-auth username |
| `ELASTICSEARCH_PASSWORD` | none | Optional Elasticsearch basic-auth password |
| `ES_BAND_INDEX` | `music_data_bands` | Elasticsearch band index |
| `ES_ARTIST_INDEX` | `music_data_artists` | Elasticsearch artist index |
| `GOOGLE_API_KEY` | none | Optional Google API key |

Elasticsearch search currently relies on the configured band and artist indexes.

## Database

Prisma manages the SQLite schema and migrations.

Apply migrations and seed the database as provided by the migration files:

```sh
npx prisma migrate deploy
```

Prisma Client generation is also run after `npm install`:

```sh
npx prisma generate
```

The generated Prisma Client is written to `src/generated/prisma/`. Do not edit it manually.

## Project structure

- `src/index.ts` — creates the Express application and Apollo GraphQL server.
- `src/config.ts` — reads environment variables and server defaults.
- `src/graphql/index.ts` — combines GraphQL type definitions and resolvers.
- `src/database.ts` — configures Prisma with the SQLite adapter.
- `src/elastic.ts` — configures the Elasticsearch client.
- `src/band/` — band, genre, and band-detail GraphQL schema and resolvers.
- `src/artist/` — artist GraphQL schema and resolvers.
- `src/album/` — album GraphQL schema and resolvers.
- `src/song/` — song GraphQL schema and resolvers.
- `src/user/` — user schema, authentication, authorization, and resolvers.
- `src/shared/` — shared formatting helpers.
- `prisma/schema.prisma` — SQLite models and relations.
- `prisma/migrations/` — database migrations and seed data.

## Architecture

- GraphQL operations are exposed at `/graphql`.
- Elasticsearch provides search and document-style music data.
- SQLite/Prisma provides relational music and user data.
- Several resolvers combine Elasticsearch documents with Prisma records. Prisma fallback data is used when an Elasticsearch document is unavailable.
- JWT authentication is implemented with an HMAC-SHA256 bearer token. Send it as `Authorization: Bearer <token>`.
- Apollo context validates the bearer token and exposes the authenticated user to resolvers.
- Administrator-only operations enforce role checks in the user resolvers.

## Client

This repository contains the API server. A React client can connect to `http://localhost:4000/graphql` or to the URL configured by `VITE_GRAPHQL_URL`.

Keep client setup and client-specific conventions in the client's own README.

## Change boundaries

- Do not manually edit `src/generated/prisma/`.
- Do not manually edit build output in `dist/`.
- Do not manually edit or remove lockfiles such as `package-lock.json`.
- Add schema changes through Prisma migrations.
- Keep authentication and resolver authorization checks on the server.
- Preserve the existing strict TypeScript settings and NodeNext module conventions.
