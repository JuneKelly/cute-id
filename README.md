cute-id
=======

Cute, Random IDs in Racket, in adjective-adjective-animal form, such as
`"Abaft-Blondish-Ocelot"`.

Adjectives and Animals borrowed from https://github.com/moparisthebest/adjective-adjective-animal.

# Example

``` racket
(require cute-id)
(println (generate-cute-id))
;; => Abaft-Blondish-Ocelot
```


## Install 

``` sh
$ raco pkg install
```


## Test

``` sh
$ raco test main.rkt
```


## Generate from Command Line

``` sh
$ racket main.rkt
# => Unilateral-Delayed-Moa
```
