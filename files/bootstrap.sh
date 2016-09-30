#/bin/bash

set -e

mkdir -p /opt/python
cd /opt/python

if [[ -e /opt/python/.bootstrapped ]]; then
  exit 0
fi

PYPY_VERSION=5.1.0

if [[ -e /opt/python/pypy-$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf /opt/python/pypy-$PYPY_VERSION-linux64.tar.bz2
else
  wget -O - https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
fi

mv -n pypy-$PYPY_VERSION-linux64 pypy

## library fixup
mkdir -p pypy/lib
ln -snf /lib64/libncurses.so.5.9 /opt/python/pypy/lib/libtinfo.so.5

mkdir -p /opt/python/bin

cat > /opt/python/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=/opt/python/pypy/lib:$LD_LIBRARY_PATH exec /opt/python/pypy/bin/pypy "\$@"
EOF

chmod +x /opt/python/bin/python
/opt/python/bin/python --version && rm -rf /opt/python/pypy-$PYPY_VERSION-linux64.tar.bz2
