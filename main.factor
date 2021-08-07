#!/usr/bin/env factor-vm
USING: kernel io
       http.client xml
       xml.traversal assocs
       sequences wrap.strings
       accessors strings
       formatting system ;
IN: main

: main ( -- )
  "https://api.forismatic.com/api/1.0/?method=getQuote&format=xml&lang=en"
  http-get swap code>> dup
  200 = [ drop
    string>xml "quote" tag-named dup
    "quoteText" tag-named children>string
    60 wrap-lines "\n " join
    [ dup 0x20 = swap 0xA = or ] trim
    "\"\e[94m\e[1m" swap "\e[0m\"" "%s%s%s\n" printf
    "quoteAuthor" tag-named dup
    [ children>string "\e[93m" swap "\e[0m" "%s%s%s\n" printf ]
    [ drop ] if
  ] [
    "\e[94m\e[1mHTTP error:\e[0m \e[91m%d\n"
    printf flush
    1 exit
  ] if
  ;

MAIN: main
