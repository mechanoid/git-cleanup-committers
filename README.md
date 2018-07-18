# git cleanup committers

Nowadays privacy standards sometimes forbid to reveal the committer history of a project when the source should be pushed to a remote server. For that reason the provided script in this project allows to rewrite the history and to donate all commits to a new fake user.

## Usage

```
./cleanup-committers.sh \
  -s [ ./some-git-repo/ | git://... ] \
  -c ./my-clone \
  -n "Carl Anonymus" \
  -e "carl.a@anonymous.com" \
  -o some-remote-repo-url
```

## Options

**-s**: source repository (either folder or an repo url)

**-c**: clone folder

**-n**: new user name for all commits

**-e**: new email for all commits

**-o**: remote repostory to push to (forced push, so branches must be unprotected)
