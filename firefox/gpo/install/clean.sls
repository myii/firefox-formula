# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import firefox with context %}

{% for template in ['firefox', 'mozilla'] %}
firefox-gpo-install-clean-file-absent-{{ template }}-admx:
  file.absent:
    - name: {{ firefox.gpo.policy_dir }}\{{ template }}.admx

firefox-gpo-install-clean-file-absent-{{ template }}-adml:
  file.absent:
    - name: {{ firefox.gpo.policy_dir }}\{{ firefox.gpo.lang }}\{{ template }}.adml
{% endfor %}
