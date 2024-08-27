{% macro prepare_wine_ratings() %}

WITH wines_with_ratings AS (
    SELECT
        product_id,
        title,
        release_date,
        price,
        user_rating,
        CASE
            WHEN user_rating >= 4.5 THEN 'Fine Wine'
            WHEN user_rating >= 3.5 THEN 'Good'
            WHEN user_rating >= 2.5 THEN 'Average'
            ELSE 'Poor'
        END AS rating_category
    FROM {{ ref('wines') }}  -- Using dbt's ref function to reference the films table
),

wines_with_grapes AS (
    SELECT
        w.product_id,
        w.title,
        STRING_AGG(g.grape_name, ', ') AS grapes
    FROM {{ ref('wines') }} w
    LEFT JOIN {{ ref('wine_grapes') }} wg ON w.product_id = wg.product_id
    LEFT JOIN {{ ref('grapes') }} g ON wg.grape_id = g.grape_id
    GROUP BY w.product_id, w.title
)

{% endmacro %}