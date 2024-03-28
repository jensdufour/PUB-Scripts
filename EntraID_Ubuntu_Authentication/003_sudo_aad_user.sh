#!/bin/bash

# Add the current user to the sudo group
sudo usermod -aG sudo $(whoami)
