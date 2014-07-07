puppet-hiera-yaml-lint
======================
Kinda lint your puppet hiera yaml files


The script uses one big regex to look for these puppet hiera style-related issues:
* keys with unquoted values, that are not booleans
* unquoted list items


## Requirements ##
 The script requires ack for prce regular expressions.

## TODO
* bark on unalphabetized files
* identify hiera calls and validate double-quoting
* find more problems with this