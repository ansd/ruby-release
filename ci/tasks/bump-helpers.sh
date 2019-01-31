function set_git_config() {
  git config user.name "$1"
  git config user.email "$2"
}

function commit_if_changed() {
  if [[ "$( git status --porcelain )" != "" ]]; then
    git commit -am "$1"
  fi
}

function replace_if_necessary() {
  version=$1
  package_name=$2
  blobname=$(basename $(ls ../${package_name}/*))
  if ! bosh blobs | grep -q ${blobname}; then
    existing_blob=$(bosh blobs | awk '{print $1}' | grep "${package_name}" || true)
    if [ -n "${existing_blob}" ]; then
      bosh remove-blob ${existing_blob}
    fi
    bosh add-blob --sha2 ../${package_name}/${blobname} ${blobname}
    bosh upload-blobs
  fi
}
