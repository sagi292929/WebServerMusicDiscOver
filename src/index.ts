import "dotenv/config";
import express from "express";
import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@as-integrations/express5";
import cors from "cors";
import { typeDefs } from "./band/schema";
import { bandResolvers as resolvers } from "./band/resolvers";
import { artistTypeDefs } from "./artist/schema";
import { artistResolvers } from "./artist/resolvers";
import { albumTypeDefs } from "./album/schema";
import { albumResolvers } from "./album/resolvers";
import { songTypeDefs } from "./song/schema";
import { songResolvers } from "./song/resolvers";
import { config } from "./config";

async function startServer() {
  const app = express();
  const server = new ApolloServer({
    typeDefs: [typeDefs, artistTypeDefs, albumTypeDefs, songTypeDefs],
    resolvers: [resolvers, artistResolvers, albumResolvers, songResolvers],
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
