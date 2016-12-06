# (The MIT license)
#
# Copyright (c) 2016 sasa+1 <sasaplus1@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

_sandbox() {
  # arguments not found
  [ "$#" -eq 0 ] && _sandbox_usage && return 1

  # sub commands
  case "$1" in
    # create sandbox
    c | create)
      shift
      _sandbox_create $*
      ;;
    # show sandboxes
    ls | list)
      shift
      _sandbox_list $*
      ;;
    # unknown
    *)
      _sandbox_usage
      ;;
  esac
}

_sandbox_create() {
  local mkdir=$(type -tP mkdir)
  local printf=$(type -tP printf)

  local sandbox_dir=${_SANDBOX_DIR:-$HOME/.sandbox}
  local sandbox_name=${1:-$(date +%FT%T)}

  $mkdir -p "${sandbox_dir}/${sandbox_name}" 2>/dev/null

  $printf -- '%s\n' "${sandbox_dir}/${sandbox_name}"
}

_sandbox_list() {
  local grep=$(type -tP grep)
  local ls=$(type -tP ls)
  local mkdir=$(type -tP mkdir)
  local printf=$(type -tP printf)
  local sed=$(type -tP sed)

  local sandbox_dir=${_SANDBOX_DIR:-$HOME/.sandbox}

  $mkdir -p "$sandbox_dir" 2>/dev/null

  local sed_script=

  if [ x"$1" = 'x-p' ]
  then
    sed_script="s|^|${sandbox_dir}/|"
  elif [ x"$1" != 'x' ]
  then
    $printf -- 'unknown argument: %s\n' "$1" >&2 && return 1
  fi

  $ls -1p "$sandbox_dir" | $grep '/$' | $sed -e 's|/$||' -e "$sed_script"
}

_sandbox_usage() {
  # CAUTION: do not delete tabs
  cat <<-USAGE >&2
	Usage:
	  sandbox [command] [args...]
	USAGE
}

alias ${_SANDBOX_CMD:-sandbox}='_sandbox'
