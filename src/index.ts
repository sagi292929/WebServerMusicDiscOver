import "dotenv/config";
import express from "express";
import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@as-integrations/express5";
import cors from "cors";
import { resolvers, typeDefs } from "./graphql";
import { config } from "./config";

async function startServer() {
  const app = express();
  const server = new ApolloServer({
    typeDefs,
    resolvers,
  });

  await server.start();

  app.use(
    "/graphql",
    cors<cors.CorsRequest>(),
    express.json(),
    expressMiddleware(server)
  );

  app.listen(config.port, () => {
    console.log(`🚀 Server ready at http://localhost:${config.port}/graphql`);
  });
}

startServer();
