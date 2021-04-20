#!/usr/bin/env bash
set -e
flutter test --coverage
lcov --remove coverage/lcov.info '**/*.g.dart' '**/*.freezed.dart' '**/*.config.dart' '**/*.mocks.dart' 'lib/gen/**' '**/*.gr.dart' -o coverage/new_lcov.info
genhtml coverage/new_lcov.info --output=coverage
if [ "$1" == "open" ]; then
  open coverage/index.html
fi
