import { prisma } from "../database";

export const albumResolvers = {
  Query: {
    getAlbum: async (_: unknown, { name }: { name: string }) => {
      const trimmedName = name.trim();
      if (!trimmedName) {
        return [];
      }
      const searchTerm = trimmedName.toLowerCase();

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
          const leftPosition = left.title.toLowerCase().indexOf(searchTerm);
          const rightPosition = right.title.toLowerCase().indexOf(searchTerm);

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
