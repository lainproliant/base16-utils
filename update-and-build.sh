#!/bin/sh
pipenv install
git submodule update --init --recursive
rm -rf ./output ./schemes ./sources ./templates
mkdir -p /tmp/go
GOPATH=/tmp/go go get github.com/thefryscorer/schemer2
chown -R lainproliant /tmp/go
chmod -R u+rwx /tmp/go
cp /tmp/go/bin/schemer2 .
rm -rf /tmp/go
pipenv run pybase16 update -c
pipenv run pybase16 build
