#!/usr/bin/env factor-vm
USING: kernel    io            http.client
       xml       xml.traversal assocs
       sequences wrap.strings  accessors
       strings   formatting    system ;
IN: past

: wrap ( str -- str )
    60 wrap-lines "\n " join [ dup 0x20 = swap 0xA = or ] trim ;

: text ( xml -- str )
    "quoteText" tag-named
    children>string wrap "\"\e[94m\e[1m%s\e[0m\"" sprintf ;

: author ( xml -- str/f )
    "quoteAuthor" tag-named dup
    [ children>string "\e[93m%s\e[0m" sprintf ] [ drop f ] if ;

: output ( str -- )
    string>xml "quote" tag-named dup text print author dup
    [ print ] [ drop ] if ;

: http-err ( code -- )
    "\e[94m\e[1mHTTP error:\e[0m \e[91m%d" printf nl flush
    1 exit ;

: past-gen ( -- )
    "https://api.forismatic.com/api/1.0/?"
    "method=getQuote&format=xml&lang=en" append
    http-get swap code>> dup 200 =
    [ drop output ] [ http-err drop ] if ;

MAIN: past-gen
