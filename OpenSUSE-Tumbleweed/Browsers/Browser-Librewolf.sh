#!/bin/bash

sudo rpm --import https://rpm.librewolf.net/pubkey.gpg
sudo zypper ar -ef https://rpm.librewolf.net librewolf
sudo zypper ref
sudo zypper in librewolf
