#!/usr/bin/env bash

[[ "$#" -eq 1 ]] || { echo "Please provide a name for your Conversation" >&2; exit 1; }
CONVERSATION_NAME=`echo $1 | tr " " _`

START_COMMIT=`git rev-parse HEAD~2`
END_COMMIT=`git rev-parse HEAD`

function createBranch {
    git checkout -b ${1}
    git push --set-upstream origin ${1}
}

function setRepoURL {
    REMOTE=`git remote -v | grep push | awk '{split($0, a, " "); print a[2]}'`
    REPO_URL=`echo ${REMOTE} | rev | cut -c5- | rev`
}


git checkout ${START_COMMIT}
START_BRANCH_NAME="${CONVERSATION_NAME}_begin"
createBranch ${START_BRANCH_NAME}

git checkout ${END_COMMIT}
END_BRANCH_NAME="${CONVERSATION_NAME}"
createBranch ${END_BRANCH_NAME}

setRepoURL
open "${REPO_URL}/compare/${START_BRANCH_NAME}...${END_BRANCH_NAME}"

git checkout master
git branch -D ${START_BRANCH_NAME}
git branch -D ${END_BRANCH_NAME}
