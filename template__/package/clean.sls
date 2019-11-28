# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import template__ with context %}

include:
  - {{ sls_config_clean }}

template__-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ template__.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
