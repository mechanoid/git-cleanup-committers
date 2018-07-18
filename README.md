# git cleanup committers

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
