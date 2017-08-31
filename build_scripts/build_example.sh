#!/usr/bin/env bash
DOC="""This script downloads, builds, and installs lorax and its dependencies.
You should stop and edit this script if you wish to:
   * install lorax to non-default locations
   * use RAxML and your system has AVX or AVX2 hardware
"""
if [ "$1" != "-y" ]; then
   echo "$DOC"
   read -p "Do you want to continue? <(y)> " response
   if [ ! -z "$response" ]; then
      if [ "$response" != "y" ]; then
         exit 1
      fi
   fi
fi
set -e
error_exit() {
  echo "ERROR--unexpected exit from ${BASH_SOURCE} at line"
  echo "   $BASH_COMMAND"
}
trap error_exit EXIT
#
# Configure the build.
#
./lorax_tool.sh init
#
# Init configures the following default paths, which you may override.
# Note that if you are building nginx, some of these set compile-time-only
# defaults which cannot be overridden.
#
#./lorax_tool.sh set directory_version 0.94
#./lorax_tool.sh set root_dir ~/lorax-`./lorax_tool.sh set directory_version`
#./lorax_tool.sh set var_dir "`./lorax_tool.sh set root_dir`/var"
#./lorax_tool.sh set tmp_dir "`./lorax_tool.sh set var_dir`/tmp"
#./lorax_tool.sh set log_dir "`./lorax_tool.sh set var_dir`/log"
#
# Version numbers of packages.  Setting these to "system" will cause them
# not to be built.
#
#./lorax_tool.sh set python 3.6.2
#./lorax_tool.sh set hmmer 3.1b2
#./lorax_tool.sh set raxml 8.2.11
#./lorax_tool.sh set redis 4.0.1
#./lorax_tool.sh set nginx 1.13.4
#
# The following defaults are platform-specific.  Linux defaults are shown.
#
#./lorax_tool.sh set platform linux
#./lorax_tool.sh set bin_dir ~/bin  # dir in PATH where lorax_env is symlinked
#./lorax_tool.sh set make make
#./lorax_tool.sh set cc gcc
#./lorax_tool.sh set redis_cflags ""
#
# The following defaults are hardware-specific for the RAxML build.
# If you have both hardware and compiler support, you may wish to substitute
# "SSE3" with either "AVX" or "AVX2".  Note that clang on BSD uses the gcc
# model, but mac has its own model.
#
#./lorax_tool.sh set raxml_model .SSE3.PTHREADS.gcc
#./lorax_tool.sh set raxml_binsuffix -PTHREADS-SSE3
#
./lorax_tool.sh set all
./lorax_tool.sh make_dirs
#
# Build the binaries.  If you give this without an argument, all binaries
# will be built (unless versions are set to "system" as noted above).
#
echo "Doing C/C++ binary installs."
./lorax_tool.sh install
#
# The following exports are needed for the freshly-built python to run
# on BSD (and probably harmless on others).
#
if [ -z "$LC_ALL" ]; then
   export LC_ALL=en_US.UTF-8
fi
if [ -z "$LANG" ]; then
   export LANG=en_US.UTF-8
fi
#
# Do pip installs.
#
echo "Doing python installs."
./lorax_tool.sh link_python    # python and pip links
./lorax_tool.sh pip_install    # Do installs for lorax and dependencies
./lorax_tool.sh link_env       # put lorax_env in PATH
#
# Test to make sure it runs.
#
echo "Testing lorax binary."
./lorax_tool.sh version > `./lorax_tool.sh set root_dir`/version
echo "Installation was successful."
echo "You should now proceed with configuring lorax via the command"
echo "   ./my_config.sh"
trap - EXIT
