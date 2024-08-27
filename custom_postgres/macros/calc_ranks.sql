{% macro calc_ranks(column_name) %}
    CASE
        WHEN {{ column_name }} >= 4.5 THEN 'Fine Wine'
        WHEN {{ column_name }} >= 3.5 THEN 'Good'
        WHEN {{ column_name }} >= 2.5 THEN 'Average'
        ELSE 'Poor'
    END
{% endmacro %}