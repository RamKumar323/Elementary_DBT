{% macro upload_information() %}
  {% set identifier = 'information' %}
  {% if results and elementary.get_result_node(identifier) %}
    {{ return('') }}
  {% endif %}

  {% set relation = elementary.get_elementary_relation(identifier) %}
  {% if not relation %}
    {{ return('') }}
  {% endif %}

  {% set data = [
    {'key': 'dbt_version', 'value': dbt_version},
    {'key': 'elementary_version', 'value': elementary.get_elementary_package_version()},
  ] %}
  {% do elementary.debug_log("Uploading information.") %}
  {% do dbt.truncate_relation(relation) %}
  {% do elementary.insert_rows(relation, data) %}
{% endmacro %}