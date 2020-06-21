---
# https://help.github.com/en/actions/language-and-framework-guides/using-python-with-github-actions
# https://github.com/actions/python-versions/blob/master/versions-manifest.json
name: __WORKFLOW_NAME__
on:
  pull_request:
  push:
    branches:
      - master
    tags:

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: False

    name: "__JOB_NAME__"
    steps:
      # ------------------------------------------------------------
      # Setup
      # ------------------------------------------------------------
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Docker versions
        shell: bash
        run: |
            docker version

      - name: Docker Compose versions
        shell: bash
        run: |
            docker-compose version

      # ------------------------------------------------------------
      # Tests: Behaviour
      # ------------------------------------------------------------

      - name: "[keep-open] before send (kill srv)"
        shell: bash
        run: |
          make _smoke-keep_open-kill_srv-before_send PYTHON_VERSION=__PYTHON_VERSION__

      - name: "[keep-open] after send (kill srv)"
        shell: bash
        run: |
          make _smoke-keep_open-kill_srv-send_data PYTHON_VERSION=__PYTHON_VERSION__

      - name: "[port scan] tcp (no banner)"
        shell: bash
        run: |
          make _smoke-tcp_port_scan-no_banner PYTHON_VERSION=__PYTHON_VERSION__

      - name: "[port scan] tcp (with banner)"
        shell: bash
        run: |
          make _smoke-tcp_port_scan-with_banner PYTHON_VERSION=__PYTHON_VERSION__

      - name: "[port scan] udp (no banner)"
        shell: bash
        run: |
          make _smoke-udp_port_scan-no_banner PYTHON_VERSION=__PYTHON_VERSION__

      - name: "[port scan] udp (with banner)"
        shell: bash
        run: |
          make _smoke-udp_port_scan-with_banner PYTHON_VERSION=__PYTHON_VERSION__
