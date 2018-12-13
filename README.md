# radex-install
:zap: Build and Install RADEX easily

> Radex is a computer program to calculate the strengths of atomic and molecular lines from interstellar clouds which are assumed to be homogeneous. - [RADEX website](https://personal.sron.nl/~vdtak/radex/index.shtml)

This project will make it easier to use RADEX for radio astronomers.
Its Makefile or Homebrew formula will make three different RADEX binaries:

| Binary | Descripion |
| --- | --- |
| `radex-sphere` | RADEX built with option 1 (uniform sphere) |
| `radex-lvg` | RADEX built with option 2 (expanding sphere) |
| `radex-slab` | RADEX built with option 3 (plane parallel slab) |

Note that molecular data directory (moldat) is not set by default.
User must spacify the full path of a file when you use RADEX
(/Users/astropenguin/moldat/co.dat, for example).

## Installation

### Homebrew

The easiest way is to use Homebrew.

```shell
$ brew tap astropenguin/formulae
$ brew install radex
```

### Clone this repository


Or you can build and install yourself.
In this case, user must prepare `gfortran` before installation.

```shell
$ git clone https://github.com/astropenguin/radex-install.git
$ cd radex-install
$ make install
```

User can spacify the default moldat directory.

```shell
$ make install MOLDAT=/Users/astropenguin/moldat
``` 
