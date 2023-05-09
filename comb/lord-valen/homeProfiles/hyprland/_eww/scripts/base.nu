#!/usr/bin/env nu

let address = $"UNIX-CONNECT:/tmp/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock"
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

def socket [events] {
  socat -u $address - | lines | each {|line|
    $line
    | split column ">>"
    | into record
    | each {|record|
      if $record.column1 in $events {"go!"}
    }
  }
}
