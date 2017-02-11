#!/bin/bash
#
# FABIC/2017-02-11
#
# Runs jekyll clean then jekyll serve

# 1st arg. may be the port number to listen to
# (note that we bind to all IPs, not just localhost)
listen_port=${1:-3838}

echo "### Jekyll clean ###"
if ! bundle exec jekyll clean ; then
    echo "# ERROR: jekyll clean exited with non-zero status code $?"
    exit 127
fi

jekyll_serve_cmd=( bundle exec jekyll serve --incremental --trace --watch --drafts --unpublished --host 0.0.0.0 --port "${listen_port}" )

echo
echo "### Jekyll serve ###"
echo "#"
echo "# Running command :"
echo "#"
echo "#   ${jekyll_serve_cmd[@]}"
echo

if ! "${jekyll_serve_cmd[@]}" ; then
    retv=$?
    echo
    echo "# WARNING: Jekyll serve ... command exit status is non-zero : $retv"
    echo
    exit $retv
fi

echo
echo "# Finished, jekyll serve command was :"
echo "#   ${jekyll_serve_cmd[@]}"
echo

