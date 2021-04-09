#!/usr/bin/env bash
build_runner_mode=$1
if [ -z "$build_runner_mode" ]
then
  build_runner_mode="build"
fi
echo ">>>Running packages pub run build_runner $build_runner_mode --delete-conflicting-outputs --no-fail-on-severe"
flutter packages pub run build_runner "$build_runner_mode" --delete-conflicting-outputs --no-fail-on-severe