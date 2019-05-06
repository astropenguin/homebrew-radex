# radex-install

[![Travis](https://img.shields.io/travis/astropenguin/radex-install/master.svg?label=Travis%20CI)](https://travis-ci.org/astropenguin/radex-install)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

:zap: Build and Install RADEX easily

## TL;DR

> Radex is a computer program to calculate the strengths of atomic and molecular lines from interstellar clouds which are assumed to be homogeneous. - [RADEX website](https://personal.sron.nl/~vdtak/radex/index.shtml)

This project will make it easier to use RADEX for radio astronomers.
The Makefile or [the Homebrew formula](https://github.com/astropenguin/homebrew-formulae) will make three different RADEX binaries:

| Binary | Descripion |
| --- | --- |
| `radex-uni` | RADEX built with option 1 (uniform sphere) |
| `radex-lvg` | RADEX built with option 2 (expanding sphere) |
| `radex-slab` | RADEX built with option 3 (plane parallel slab) |

Note that the path of data directory (`radat`) is not set by default.
User must specify the full path of a data file when you run a RADEX binary
(e.g., /Users/astropenguin/radex/data/co.dat).

## Installation

### Homebrew

The easiest way is to use Homebrew.

```shell
$ brew tap astropenguin/formulae
$ brew install radex
```

As a dependency, `gcc` (for using `gfortran`) will be also installed.

### Clone this repository

You can also build and install by yourself.
In this case, user must prepare `gfortran` before installation.

```shell
$ git clone https://github.com/astropenguin/radex-install.git
$ cd radex-install
$ make install
```

You can specify the path of data directory.

```shell
# do not forget the slash at the end of path
$ make install DATADIR=/Users/astropenguin/radex/data/
```
