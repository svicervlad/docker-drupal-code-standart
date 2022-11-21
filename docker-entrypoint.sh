#!/bin/bash


export PATH="$PATH:/root/.composer/vendor/bin"

phpcs \
  --standard=Drupal,DrupalPractice \
  --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml \
  --report=junit "$@"

