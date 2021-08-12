#!/usr/bin/env factor-vm
USING: command-line         io            io.backend
       io.pathnames         kernel        namespaces
       sequences            tools.deploy  tools.deploy.config
       tools.deploy.backend vocabs.loader ;

IN: deploy-me

: load-and-deploy ( path/vocab -- )
    normalize-path
    [ parent-directory add-vocab-root ]
    [ file-name dup reload deploy ] bi ;

: deploy-vocab ( path/vocab path/target -- )
    normalize-path deploy-directory set
    f open-directory-after-deploy? set load-and-deploy ;

: deploy-me ( -- )
    command-line get dup length 2 =
    [ first2 deploy-vocab ] [
        drop
        "usage: deploy-me <PATH-TO-VOCAB> <TARGET-DIR>" print nl
    ] if ;

MAIN: deploy-me
