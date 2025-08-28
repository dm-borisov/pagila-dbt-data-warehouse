{{
    config(
        materialized = 'table'
    )
}}
SELECT
    film_id,
    title,
    "description",
    release_year,
    language_id,
    original_language_id,
    rental_duration,
    rental_rate,
    "length",
    replacement_cost,
    rating,
    last_update,
    special_features
FROM {{ source('backend_src', 'film') }}
