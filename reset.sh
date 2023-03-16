#!/bin/bash

git fetch
git pull

rm *.yaml
rm ./catalog/*.yaml
rm ./app-chart/templates/*.yaml

git add .
git commit -m"reset demo"
git push