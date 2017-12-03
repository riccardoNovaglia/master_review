#!/usr/bin/env bash

CONVERSATION_NAME=""
START_COMMIT=""
END_COMMIT=""

while getopts 'c:s:e:' flag; do
  case "${flag}" in
    c) CONVERSATION_NAME="${OPTARG}" ;;
    s) START_COMMIT="${OPTARG}" ;;
    e) END_COMMIT="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

[[ ! -z ${CONVERSATION_NAME} ]] || { echo "Please provide a name for your Conversation" >&2; exit 1; }
[[ ! -z ${START_COMMIT} ]] || { echo "Please provide a start commit (can be symbolic)" >&2; exit 1; }
[[ ! -z ${END_COMMIT} ]] || { echo "Please provide an commit (can be symbolic)" >&2; exit 1; }

VALIDATED_CONVERSATION_NAME=`echo ${CONVERSATION_NAME} | tr " " _`
START_COMMIT_HASH=`git rev-parse ${START_COMMIT}`
END_COMMIT_HASH=`git rev-parse ${END_COMMIT}`

echo "Setting up conversation [$VALIDATED_CONVERSATION_NAME] between commits [$START_COMMIT_HASH] and [$END_COMMIT_HASH]"

function createBranch { git checkout -b ${1}; git push -q --set-upstream origin ${1}; }
function quietlyCheckout { git checkout -q ${1}; }

quietlyCheckout ${START_COMMIT_HASH}
START_BRANCH_NAME="${VALIDATED_CONVERSATION_NAME}_begin"
createBranch ${START_BRANCH_NAME}

quietlyCheckout ${END_COMMIT_HASH}
END_BRANCH_NAME="${VALIDATED_CONVERSATION_NAME}"
createBranch ${END_BRANCH_NAME}

REPO_URL=`git remote -v | grep push | awk '{split($0, a, " "); print a[2]}' | rev | cut -c5- | rev`
open "${REPO_URL}/compare/${START_BRANCH_NAME}...${END_BRANCH_NAME}"

git checkout -q master
git branch -D ${START_BRANCH_NAME}
git branch -D ${END_BRANCH_NAME}
