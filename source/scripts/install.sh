#!/bin/bash

source config/export.sh

echo yo_user: $yo_user
echo -n yo_pass: && [ -z "$yo_pass" ] && echo " error: password is empty" || echo " ****"
echo yo_root: "****"
echo yo_device: $yo_device
echo yo_deswap: $yo_deswap
echo yo_depast: $yo_depast
echo yo_deroot: $yo_deroot
echo yo_deboot: $yo_deboot
echo yo_deuefi: $yo_deuefi
echo yo_decode: $yo_decode
echo yo_dedata: $yo_dedata
echo yo_zone: $yo_zone
echo yo_lang: $yo_lang
echo yo_keys: $yo_keys

# after user creation
unset $yo_root
unset $yo_pass