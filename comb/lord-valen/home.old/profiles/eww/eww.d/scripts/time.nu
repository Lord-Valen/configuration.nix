#!/usr/bin/env nu

date now | date format "%Y|%m|%d|%H|%M|%Z" | split column "|" | rename year month day hour minute timezone | into record | to json -r | print
