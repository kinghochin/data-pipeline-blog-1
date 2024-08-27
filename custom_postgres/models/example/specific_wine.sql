{% set wine_title = '19 Crimes Red Wine 75Cl' %}

SELECT *
FROM {{ ref('wines') }}
WHERE title = '{{ wine_title }}'