#!/bin/bash
# Based on: https://gist.github.com/Stebalien/d4a32c4abc03376db903
set -e
[[ "$(git symbolic-ref --short HEAD)" == "master" ]] || exit 0

msg() {
    echo "[1;34m> [1;32m$@[0m"
}

dir="$(pwd)"
repo_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$repo_dir"
mkdir -p docs

tmp="$(mktemp -d)"
last_rev="$(git rev-parse HEAD)"
last_msg="$(git log -1 --pretty=%B)"

trap "cd \"$dir\"; rm -rf \"$tmp\"" EXIT

msg "Cloning into a temporary directory..."
git clone -qb gh-pages $repo_dir $tmp
cd "$tmp"
git checkout -q master
ln -s $repo_dir/docs $tmp/docs

msg "Generating documentation..."
appledoc \
	--project-name "LXTouchGestureRecognizer" \
	--project-company " " \
	--company-id " " \
	--output "docs" \
	--no-create-docset .

mv docs/html docs.new
rm -rf docs
mv docs.new docs

# Switch to pages
msg "Replacing documentation..."
git checkout -q gh-pages

# Clean and replace
git rm -q --ignore-unmatch -rf .
git reset -q -- .gitignore
git checkout -q -- .gitignore
cp -a docs/* .
rm docs
git add .
git commit -m ":memo: Update docs for $last_rev" -m "$last_msg"
git push -qu origin gh-pages
msg "Done."
