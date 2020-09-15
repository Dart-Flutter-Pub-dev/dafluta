#!/bin/sh

set -e

./test.sh
flutter format ./lib
flutter packages pub publish