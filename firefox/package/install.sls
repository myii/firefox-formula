# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import firefox with context %}

firefox-package-install-pkg-installed:
  pkg.installed:
    - name: {{ firefox.pkg.name }}
