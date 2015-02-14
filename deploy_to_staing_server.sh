#!/bin/sh

echo "Creating pull request..."
DATE=`date +'%Y-%m-%d %H:%M:%S'`
URL=`hub pull-request -m "$DATE Staging deployment" -b deploy/staging -h master`
if [ $? -eq 0 ]; then
    echo "Pull request created (url='$URL')"
else
    exit 1
fi
