# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_gpo_install = tplroot ~ '.gpo.install' %}
{%- from tplroot ~ "/map.jinja" import firefox with context %}
{%- set gpo = firefox.gpo %}

include:
  - {{ sls_gpo_install }}

{% if gpo.policies is mapping %}
firefox-gpo-config-lgpo-set:
  lgpo.set:
    - computer_policy: {{ gpo.policies | json }}
    - require:
      - sls: {{ sls_gpo_install }}

firefox-gpo-config-cmd-run:
  cmd.run:
    - name: gpupdate /wait:0
    - onchanges:
      - lgpo: firefox-gpo-config-lgpo-set
{% endif %}
