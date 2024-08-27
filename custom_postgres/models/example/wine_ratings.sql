{{ prepare_wine_ratings() }}

SELECT
    wwr.*,
    wwg.grapes
FROM wines_with_ratings wwr
LEFT JOIN wines_with_grapes wwg ON wwr.product_id = wwg.product_id