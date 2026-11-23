import { prisma } from "../database";
import {
  normalizeSearchText,
  trimSearchInput,
} from "../shared/formatting";

export const albumResolvers = {
  Query: {
    getAlbum: async (_: unknown, { name }: { name: string }) => {
      const trimmedName = trimSearchInput(name);
      if (!trimmedName) {
        return [];
      }
      const searchTerm = normalizeSearchText(trimmedName);

      const albums = await prisma.album.findMany({
        where: {
          title: {
            contains: trimmedName,
          },
        },
        select: {
          Id: true,
          title: true,
          year: true,
          lengthMinutes: true,
          band: {
            select: {
              name: true,
            },
          },
        },
        orderBy: [{ title: "asc" }, { year: "asc" }],
      });

      return albums
        .sort((left, right) => {
          const leftPosition = normalizeSearchText(left.title).indexOf(
            searchTerm
          );
          const rightPosition = normalizeSearchText(right.title).indexOf(
            searchTerm
          );

          return (
            leftPosition - rightPosition ||
            left.title.localeCompare(right.title) ||
            left.year - right.year ||
            left.Id - right.Id
          );
        })
        .map(({ band, ...album }) => ({
          ...album,
          bandName: band.name,
        }));
    },
  },
};
