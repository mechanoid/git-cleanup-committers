#!/usr/bin/env bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Initialize our own variables:
src_repository=""
clone=""
committer_name="Carl Anonymus"
committer_email="carl.a@anonymous.com"
new_origin=""

while getopts "s:c:?n:?e:?o:" opt; do
  # echo $opt
    case "$opt" in
    s)  src_repository=$OPTARG
        ;;
    c)  clone=$OPTARG
        ;;
    n)  committer_name=$OPTARG
        ;;
    e)  committer_email=$OPTARG
        ;;
    o)  new_origin=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))


printf "\n${GREEN}Source-Repository:${NC} $src_repository"
printf "\n${GREEN}Clone Target (Directory):${NC} $clone"
printf "\n${GREEN}New Committer Name:${NC} $committer_name"
printf "\n${GREEN}New Committer Email:${NC} $committer_email"
printf "\n${GREEN}Target Repository:${NC} $new_origin\n\n"


git clone --bare $src_repository $clone
cd $clone
git remote rm origin

echo ""
echo "Rewriting all Commits to new user: ($committer_name / $committer_email)"
echo ""
git filter-branch --force --env-filter "
export GIT_COMMITTER_NAME=$committer_name
export GIT_COMMITTER_EMAIL=$committer_email
export GIT_AUTHOR_NAME=$committer_name
export GIT_AUTHOR_EMAIL="$committer_email"
" -- --tags --branches

if [ "$new_origin" == "" ]
then
  printf "\n${YELLOW}WARN:${NC} No Origin given: please set -o option for pushing the results to a remote origin"
:
else
  printf "\n${GREEN}Pushing to Origin:${NC} $new_origin\n\n"

  git remote add origin $new_origin
  git push -f origin --all
  git push -f origin --tags
fi
