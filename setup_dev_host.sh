#!/bin/bash 
# setup python3 virtual env
[ ! -d venv ] && python3 -m venv venv
venv/bin/pip install -U pip
venv/bin/pip install -r requirements.txt
