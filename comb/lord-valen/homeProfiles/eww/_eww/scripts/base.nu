#!/usr/bin/env nu

let socket = $"UNIX-CONNECT:/tmp/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock"
let names = [
  "sys"
  "doc"
  "www"
  "dev"
  "cht"
  "gam"
  "mus"
  "un8"
  "un9"
  "tst"
]
