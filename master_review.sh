#!/usr/bin/env bash

FEATURE_NAME="A_NEW_FEATURE"

FEATURE_START_COMMIT=`git rev-parse HEAD~2`
FEATURE_END_COMMIT=`git rev-parse HEAD`

function createBranch {
    git checkout -b ${1}
    git push --set-upstream origin ${1}
}

function setRepoURL {
    REMOTE=`git remote -v | grep push | awk '{split($0, a, " "); print a[2]}'`
    REPO_URL=`echo ${REMOTE} | rev | cut -c5- | rev`
}


git checkout ${FEATURE_START_COMMIT}
FEATURE_START_BRANCH_NAME="${FEATURE_NAME}_begin"
createBranch ${FEATURE_START_BRANCH_NAME}

git checkout ${FEATURE_END_COMMIT}
FEATURE_END_BRANCH_NAME="${FEATURE_NAME}_end"
createBranch ${FEATURE_END_BRANCH_NAME}

setRepoURL
open "${REPO_URL}/compare/${FEATURE_START_BRANCH_NAME}...${FEATURE_END_BRANCH_NAME}"

git checkout master
