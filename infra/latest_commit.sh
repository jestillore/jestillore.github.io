#!/bin/sh

echo "{\"commit_hash\": \"$(git rev-parse HEAD)\"}"
