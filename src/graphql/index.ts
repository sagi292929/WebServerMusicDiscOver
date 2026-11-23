import { typeDefs as bandTypeDefs } from "../band/schema";
import { bandResolvers } from "../band/resolvers";
import { artistTypeDefs } from "../artist/schema";
import { artistResolvers } from "../artist/resolvers";
import { albumTypeDefs } from "../album/schema";
import { albumResolvers } from "../album/resolvers";
import { songTypeDefs } from "../song/schema";
import { songResolvers } from "../song/resolvers";

export const typeDefs = [
  bandTypeDefs,
  artistTypeDefs,
  albumTypeDefs,
  songTypeDefs,
];

export const resolvers = [
  bandResolvers,
  artistResolvers,
  albumResolvers,
  songResolvers,
];
