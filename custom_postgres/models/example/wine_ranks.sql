SELECT
    product_id,
    title,
    user_rating,
    {{ calc_ranks('user_rating') }} AS rating_category,
    release_date
FROM {{ ref('wines') }}