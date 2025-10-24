{{config(
    materialized='external',
    location='output/matches.parquet',
    format='parquet'
)}}

WITH noWinLoss AS (
    SELECT COLUMNS(col ->
        NOT regexp_matches(col, 'w_.*') AND 
        NOT regexp_matches(col, 'L_.*')
    ) -- this selects all columns that dont start with w_ or l_
    FROM {{ source('github', 'matches_file') }}
)

SELECT * REPLACE (
    cast(strptime(CAST(tourney_date AS VARCHAR), '%Y%m%d') AS date) as tourney_date
)
FROM noWinLoss -- this grabs all columns from out noWinLoss CTE but it replaces the tourney_date by our formatted tourney_date in place
WHERE surface IS NOT NULL

