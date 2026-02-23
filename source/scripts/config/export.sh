#!/bin/bash

read -p "your username: " t_ && export yo_user=$t_ && echo
[ -z "$yo_user" ] && echo "username cannot be empty" && exit 1
read -sp "your password: " t_ && export yo_pass=$t_ && unset t_ && echo
[ -z "$yo_pass" ] && echo "password cannot be empty" && exit 1
read -sp "confirm password: " t_ && export yo_pass_=$t_ && unset t_ && echo

[ "$yo_pass" != "$yo_pass_" ] && echo "passwords do not match" && exit 1
unset $yo_pass_