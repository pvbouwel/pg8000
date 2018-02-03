set -x
set -e

BUILDROOT=$HOME/pg8000

if [[ ! -e pypy3.3-5.5-alpha-20161013-linux_x86_64-portable/bin/pypy ]]; then
    wget https://bitbucket.org/squeaky/portable-pypy/downloads/pypy3.3-5.5-alpha-20161013-linux_x86_64-portable.tar.bz2
    tar -jxf pypy3.3-5.5-alpha-20161013-linux_x86_64-portable.tar.bz2
    rm -f pypy3.3-5.5-alpha-20161013-linux_x86_64-portable.tar.bz2
fi

ln -s $BUILDROOT/pypy3.3-5.5-alpha-20161013-linux_x86_64-portable/bin/pypy ~/bin/pypy3
[ec2-user@ip-172-31-7-186 pg8000]$ cat circleci/run-postgres-and-tox.sh
./pgsql-9.1.22/bin/postgres -D `pwd`/pgsql-9.1.22/data -p 5491 &> pgsql-9.1.log
./pgsql-9.2.17/bin/postgres -D `pwd`/pgsql-9.2.17/data -p 5492 &> pgsql-9.2.log
./pgsql-9.3.13/bin/postgres -D `pwd`/pgsql-9.3.13/data -p 5493 &> pgsql-9.3.log
./pgsql-9.4.8/bin/postgres -D `pwd`/pgsql-9.4.8/data -p 5494 &> pgsql-9.4.log
./pgsql-9.5.3/bin/postgres -D `pwd`/pgsql-9.5.3/data -p 5495 &> pgsql-9.5.log

cd ~postgres/pg8000-src/
tox
