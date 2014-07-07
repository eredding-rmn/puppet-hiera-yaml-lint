#!/bin/bash
####################################
### puppet-hiera-yaml-lint.sh
#
#  this kinda lints puppet hiera yaml files.
#
#
########################
usage() {
  echo <<USAGE
  puppet-hiera-yaml-lint.sh [-h]
     Kinda lint your puppet hiera yaml files

  Requirements: The script requires ack for prce regular expressions.

  The script uses one big regex to look for these puppet hiera style-related issues:
   - keys with unquoted values, that are not booleans
   - unquoted list items

   TODO:
   - bark on unalphabetized files
   - identify hiera calls and validate double-quoting
   - find more problems with this

USAGE

}

ACK=$(which ack)
if [ -z $ACK ]; then
  usage ();
  exit 1;
fi

if [ $1 == '-h' ]; then
  usage ();
  exit 1;
fi

for file in $(git diff --name-only --cached | grep -E '\.(yml|yaml)')
do
  echo "### Checking for yaml style ===> ${file}"
  ack -v '(?:[ ]*?(?:[\]\}#]+))|((?:[ a-zA-Z-_]|:{2}|-)*?(?:[a-zA-Z0-9-_]|-)+:\n)|(?:((?:[ a-zA-Z-_]|:{2}|-)*?:)(?:\s*?)((?:(["'"'"'])(?:\\\1|.)*?\4)+|(?:true)+|(?:false)+|(?:[\{\[\|])+))' ${file} | ack '^((?:[ a-zA-Z-_]|:{2}|-)*?:)'
done

