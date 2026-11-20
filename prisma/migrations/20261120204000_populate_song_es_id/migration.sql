WITH normalized AS (
    SELECT
        "Id",
        lower(
            replace(
                replace("title", 'ç', 'c'),
                'ê',
                'e'
            )
        ) AS slug
    FROM "Song"
),
cleaned AS (
    SELECT
        "Id",
        replace(
            replace(
                replace(
                    replace(
                        replace(
                            replace(
                                replace(
                                    replace(slug, '''', ''),
                                    ',',
                                    ''
                                ),
                                '.',
                                ''
                            ),
                            '/',
                            ''
                        ),
                        '(',
                        ''
                    ),
                    ')',
                    ''
                ),
                '!',
                ''
            ),
            '?',
            ''
        ) AS slug
    FROM normalized
),
dashed AS (
    SELECT
        "Id",
        replace(
            replace(
                replace(slug, ' ', '-'),
                '--',
                '-'
            ),
            '--',
            '-'
        ) AS slug
    FROM cleaned
)
UPDATE "Song"
SET "es_id" = 'songs-' || trim(dashed.slug, '-')
FROM dashed
WHERE dashed."Id" = "Song"."Id"
  AND ("Song"."es_id" = '' OR "Song"."es_id" IS NULL);
