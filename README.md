# homebrew-radex

[![Release](https://img.shields.io/github/v/release/astropenguin/homebrew-radex?display_name=tag&label=Release&color=cornflowerblue&style=flat-square)](https://github.com/astropenguin/homebrew-radex/releases)
[![DOI](https://img.shields.io/badge/DOI-10.5281/zenodo.7086636-cornflowerblue?style=flat-square)](https://doi.org/10.5281/zenodo.7086636)
[![Tests](https://img.shields.io/github/actions/workflow/status/astropenguin/homebrew-radex/tests.yml?label=Tests&style=flat-square)](https://github.com/astropenguin/homebrew-radex/actions)

RADEX installation by Homebrew

## Overview

This project provides a Homebrew formula for [RADEX], which automatically builds and installs RADEX to your environment.
Now you can install RADEX by the following command:

```shell
brew install astropenguin/radex/radex
```

## RADEX commands

The following three commands will be installed:

| Command | Descripion |
| --- | --- |
| `radex-uni` | RADEX built with option 1 (uniform sphere) |
| `radex-lvg` | RADEX built with option 2 (expanding sphere) |
| `radex-slab` | RADEX built with option 3 (plane parallel slab) |

As a major difference from the normal RADEX command, the path of the data directory (`radat`) is not set by default:
This allows you to specify the relative or full path of a data file (`.dat`).
Note that the tilde expansion (i.e. `~/`) cannot be used for the path specification.

## Customization

The following environment variables can be set for the RADEX installation:

| Variable | Default | Description |
| --- | --- | --- |
| `HOMEBREW_DATADIR` | not set (see above) | Path of the directory for RADEX data files (`.dat`) |
| `HOMEBREW_LOGFILE` | `./radex.log` | Path of the RADEX log file |
| `HOMEBREW_MINITER` | `10` | The number of minimum iterations in a RADEX calculation |
| `HOMEBREW_MAXITER` | `9999` | The number of maximum iterations in a RADEX calculation |

For example, if you want to set the data directory:

```shell
HOMEBREW_DATADIR=${HOME}/radex brew install astropenguin/radex/radex
```

<!-- References -->
[RADEX]: https://personal.sron.nl/~vdtak/radex/index.shtml
