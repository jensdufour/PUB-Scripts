#!/bin/bash

group="users"

# Get all users that are members of the group
users=$(getent group $group | cut -d: -f4)

# Delete each user
for user in $users; do
    userdel $user
done
