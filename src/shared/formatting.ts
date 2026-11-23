export function trimSearchInput(value: string | null | undefined) {
  return value?.trim();
}

export function normalizeSearchText(value: string) {
  return value.toLowerCase();
}

export function escapeWildcardSearchInput(value: string) {
  return value.replace(/[\\*?]/g, "\\$&");
}

export function formatBirthday(value: Date | string | null | undefined) {
  if (value == null) {
    return null;
  }

  const date =
    value instanceof Date
      ? value.toISOString().slice(0, 10)
      : value.slice(0, 10);
  return date.replace(/-/g, ":");
}
