#!/usr/bin/env bash

set -eux

: ${RUBY_VERSION:?}
: ${RUBYGEMS_VERSION:?}
: ${LIBYAML_VERSION:?}

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd bumped-ruby-release

git clone ../ruby-release .

set +x
echo "${PRIVATE_YML}" > config/private.yml
set -x

set_git_config "CI Bot" "cf-bosh-eng@pivotal.io"

replace_if_necessary "${RUBY_VERSION}" "ruby-2.4"
commit_if_changed "Bump ruby ${RUBY_VERSION}"

replace_if_necessary "${RUBYGEMS_VERSION}" "rubygems"
commit_if_changed "Bump rubygems ${RUBYGEMS_VERSION}"

replace_if_necessary "${LIBYAML_VERSION}" "yaml"
commit_if_changed "Bump libyaml ${LIBYAML_VERSION}"
