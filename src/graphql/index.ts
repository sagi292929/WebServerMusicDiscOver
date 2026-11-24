import { typeDefs as bandTypeDefs } from "../band/schema";
import { bandResolvers } from "../band/resolvers";
import { artistTypeDefs } from "../artist/schema";
import { artistResolvers } from "../artist/resolvers";
import { albumTypeDefs } from "../album/schema";
import { albumResolvers } from "../album/resolvers";
import { songTypeDefs } from "../song/schema";
import { songResolvers } from "../song/resolvers";
import { userTypeDefs } from "../user/schema";
import { userResolvers } from "../user/resolvers";

export const typeDefs = [
  bandTypeDefs,
  artistTypeDefs,
  albumTypeDefs,
  songTypeDefs,
  userTypeDefs,
];

export const resolvers = [
  bandResolvers,
  artistResolvers,
  albumResolvers,
  songResolvers,
  userResolvers,
];
