#!/bin/sh

set -e

if [ "$TRAVIS_PULL_REQUEST" = false ]
then
    TARGET_BRANCH=master
else
    TARGET_BRANCH="$TRAVIS_BRANCH"
fi

if [ x"$TARGET_BRANCH" = x ]
then
    echo "No target branch found"
    exit 1
fi

git checkout "$TARGET_BRANCH"

for d in t tests test spec
do
    git checkout HEAD@{1} -- $d || true > /dev/null
done

! bundle exec rake test
