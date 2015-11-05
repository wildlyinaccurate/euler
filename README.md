<h1 align="center">Euler</h1>

<p align="center">
  <a href="https://travis-ci.org/wildlyinaccurate/euler">
    <img src="https://travis-ci.org/wildlyinaccurate/euler.svg?branch=master">
  </a>
</p>

## Installation

You'll need a recent version of GHC and Cabal.

```
$ git clone https://github.com/wildlyinaccurate/euler.git
$ cd euler
$ cabal sandbox init
$ cabal install
$ cabal build
```

## Usage

```
$ cat /path/to/the/configuration.yaml | bin/euler
```

## Configuration Format

A configuration file must be a list of components in YAML format. See [layouts/topic.yaml](layouts/topic.yaml) for an example configuration.

## huh?

shhh.
