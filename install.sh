#!/bin/bash

set -uex

# default installation on linux

## ensure go and git are installed is installed
type go >/dev/null
type git >/dev/null

## download homemaker
go install foosoft.net/projects/homemaker@latest
${HOME}/go/bin/homemaker -clobber --verbose --task=bash --variant=linux config.toml .


