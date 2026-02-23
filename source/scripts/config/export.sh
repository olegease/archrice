#!/bin/bash

read -p "your username: " t_ && export yo_user=$t_ && echo
[ -z "$yo_user" ] && echo "username cannot be empty" && exit 1
read -sp "your password: " t_ && export yo_password=$t_ && unset t_ && echo
[ -z "$yo_password" ] && echo "password cannot be empty" && exit 1
read -sp "confirm password: " t_ && export yo_password_confirm=$t_ && unset t_ && echo

[ "$yo_password" != "$yo_password_confirm" ] && echo "passwords do not match" && exit 1