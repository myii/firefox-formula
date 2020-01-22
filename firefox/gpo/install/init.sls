# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import firefox with context %}
{%- set gpo = firefox.gpo %}

{% for template in ['firefox', 'mozilla'] %}
firefox-gpo-install-file-managed-{{ template }}-admx:
  file.managed:
    - name: {{ gpo.policy_dir }}\{{ template }}.admx
    - source: https://github.com/mozilla/policy-templates/raw/v{{ gpo.policy_revision }}/windows/{{ template }}.admx
    - source_hash: {{ gpo.policy_hash[gpo.policy_revision][template]['admx'] }}
    - win_owner: {{ gpo.file_owner }}

firefox-gpo-install-file-managed-{{ template }}-adml:
  file.managed:
    - name: {{ gpo.policy_dir }}\{{ gpo.lang }}\{{ template }}.adml
    - source: https://github.com/mozilla/policy-templates/raw/v{{ gpo.policy_revision }}/windows/{{ gpo.lang }}/{{ template }}.adml
    - source_hash: {{ gpo.policy_hash[gpo.policy_revision][template]['adml'] }}
    - win_owner: {{ gpo.file_owner }}
{% endfor %}
