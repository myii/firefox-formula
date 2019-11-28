# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import template__ with context %}

template__-service-clean-service-dead:
  service.dead:
    - name: {{ template__.service.name }}
    - enable: False
