# radex-install

[![Travis](https://img.shields.io/travis/astropenguin/radex-install/master.svg?label=Travis%20CI)](https://travis-ci.org/astropenguin/radex-install)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?label=License)](LICENSE)

:zap: Build and Install RADEX easily

## TL;DR

> Radex is a computer program to calculate the strengths of atomic and molecular lines from interstellar clouds which are assumed to be homogeneous. - [RADEX website](https://personal.sron.nl/~vdtak/radex/index.shtml)

This project will make it easier to use RADEX for radio astronomers.
The Makefile or [the Homebrew formula](https://github.com/astropenguin/homebrew-formulae) will automatically build and install three different RADEX binaries:

| Binary | Descripion |
| --- | --- |
| `radex-uni` | RADEX built with option 1 (uniform sphere) |
| `radex-lvg` | RADEX built with option 2 (expanding sphere) |
| `radex-slab` | RADEX built with option 3 (plane parallel slab) |

As a major difference from the normal RADEX installation, the path of data directory (the parameter of `radat`) is not set by default.
This allows users to specify the relative or full path of a data file when you run RADEX.
Please note that the tilde expansion (e.g., ~/) cannot be used.

## Installation

### Homebrew

The easiest way is to use Homebrew:

```shell
$ brew tap astropenguin/formulae
$ brew install radex
```

As a dependency, `gcc` (for using `gfortran`) will be also installed.
The built binaries are installed in Homebrew's bin directory in the same manner as other Homebrew's formulae.

### Clone this repository

Another way is to build and install by yourself:

```shell
$ git clone https://github.com/astropenguin/radex-install.git
$ cd radex-install
$ make install
```

Users must prepare `gfortran` before the installation.
The built binaries are installed in ~/.local/bin and these paths are symlinked to /usr/local/bin.
In this way of the installation, you can customize several parameters like:

```shell
$ make install DATADIR=/Users/astropenguin/radex/data/
```

The list of all customizable parameters are listed below.

| Parameter | Default | Description |
| --- | --- | --- |
| `DATADIR` | not defined (see above) | path of directory for RADEX data files (.dat) |
| `LOGFILE` | `./radex.log` | path of log file |
| `MINITER` | `10` | the number of minimum iterations in RADEX |
| `MAXITER` | `9999` | the number of maximum iterations in RADEX |
