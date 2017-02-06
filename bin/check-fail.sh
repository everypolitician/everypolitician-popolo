#!/bin/sh

set -e

if [ "$TRAVIS_PULL_REQUEST" = false ]
then
    TARGET_BRANCH=master
else
    TARGET_BRANCH="$TRAVIS_BRANCH"
    PR_API_URL="https://api.github.com/repos/${TRAVIS_REPO_SLUG}/pulls/${TRAVIS_PULL_REQUEST}"
    if curl -s "$PR_API_URL" | grep -i refactor
    then
        echo "The title of the PR indicates this is a refactoring; skipping this check"
        exit 0
    fi
fi

if [ x"$TARGET_BRANCH" = x ]
then
    echo "No target branch found"
    exit 1
fi

git checkout "$TARGET_BRANCH"

for d in t tests test spec
do
    git checkout HEAD@{1} -- $d 2> /dev/null || true
done

if bundle exec rake test
then
    echo "Your newly introduced tests should have failed on $TARGET_BRANCH"
    exit 1
else
    echo "Your new tests failed on $TARGET_BRANCH, which is a good thing!"
fi
