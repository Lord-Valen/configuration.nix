#!/usr/bin/env nu

date now | date to-record | to json -r | print
