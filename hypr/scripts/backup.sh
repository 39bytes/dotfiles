#!/bin/bash
set -e

cd Vaults/Personal
echo $(pwd)
git add .

cur_date=$(date +"%d/%m/%Y %r")

git commit -m "$cur_date"
git push

