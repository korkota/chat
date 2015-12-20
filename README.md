# Multithreaded chat server [![Build Status](https://travis-ci.org/korkota/chat.svg?branch=master)](https://travis-ci.org/korkota/chat) [![Coverage Status](https://coveralls.io/repos/korkota/chat/badge.svg?branch=master&service=github)](https://coveralls.io/github/korkota/chat?branch=master)

![example](https://cloud.githubusercontent.com/assets/5577536/11919400/bd3e8308-a762-11e5-8bae-eb7fbda3663a.png)

## Server
    [root@localhost chat] # dart bin/server.dart --help
    
    Multithreaded chat server.
    
    -t, --threads    Number of threads.
                     (defaults to "4")
    
    -h, --host       Host name.
                     (defaults to "127.0.0.1")
    
    -p, --port       Port number.
                     (defaults to "4040")
    
        --help       Prints this help.

## CLI client

    [root@localhost chat] # dart bin/client.dart --help
    
    CLI chat client.
    
    -s, --server    Path to chat server.
                    (defaults to "ws://127.0.0.1:4040/ws")
    
    -h, --help      Prints this help.


## Web client
Default server: `ws://127.0.0.1:4040/ws`

    [root@localhost chat] # pub get
    [root@localhost chat] # pub serve
