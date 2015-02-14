#!/bin/sh

echo "Creating pull request..."
STAGING_BRANCH="deploy/staging"
DATE=`date +'%Y-%m-%d %H:%M:%S'`
URL=`hub pull-request -m "$DATE Staging deployment" -b $STAGING_BRANCH -h master`
if [ $? -eq 0 ]; then
    echo "Pull request created (url='$URL')."
else
    echo "Failed to create pull request."
    exit 1
fi

echo "Merging pull request..."
CURRENT_BRANCH=`git symbolic-ref --quiet --short HEAD 2> /dev/null`
git checkout "$STAGING_BRANCH" \
    && hub merge "$URL" \
    && git push origin "$STAGING_BRANCH" \
    && git checkout "$CURRENT_BRANCH"
if [ $? -eq 0 ]; then
    echo "Pull request merged."
else
    echo "Failed to merge pull request."
    exit 1
fi
