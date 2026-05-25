{% macro check_any_null(columns_list) %}

  {# Génère une condition pour chaque colonne de la liste et les sépare par un OR #}
  CASE 
    WHEN 
      {% for col in columns_list %}
        {{ col }} IS NULL
        {% if not loop.last %} OR {% endif %}
      {% endfor %}
    THEN 1
    ELSE 0
  END

{% endmacro %}