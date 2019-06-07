# A Homebrew repository

`hazelcast` is a command line tool that is able to control [Hazelcast IMDG](https://hazelcast.org)
member instances.

## About

This repository contains the Homebrew formula for the `hazelcast` command line tool.

See https://github.com/hazelcast/hazelcast-command-line for the source code.

## How to install

    $ brew tap hazelcast/homebrew-hazelcast
    $ brew install hazelcast

### Tab completion support

To enable tab completion on Bash add the following command to your profile:

    if which hazelcast > /dev/null; then eval "$(hazelcast init -)"; fi

### To clean up everything (may come in handy):

    $ brew uninstall hazelcast
    $ brew untap hazelcast/homebrew-hazelcast
    $ brew cleanup -s
