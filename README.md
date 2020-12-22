<!-- Reference-style links to make tables & lists more readable -->
[Gallery]: <https://github.com/ma-laforge/FileRepo/blob/master/CMDimData>


# JuliaApplications.jl

[![Build Status](https://travis-ci.org/ma-laforge/JuliaApplications.jl.svg?branch=master)](https://travis-ci.org/ma-laforge/JuliaApplications.jl)

Develop conventional applications in Julia.
Provides tools to help deploy/execute conventional applications in Julia.

<a name="Background"></a>
## Background
Julia "Project Environments" provide a set of packages to experiment with particular problem spaces. Julia users typically use problem-specific "scripts" for this type of experimentation.

By default, project environments are meant for more exploratory/interactive execution environments.

In comparison, conventional applications tend to run specific code when executed. JuliaApplications.jl therefore provides tools to help configure the Julia environment, and launch said code.

## Table of contents

 1. [Background](#Background)
 1. [Installation](#Installation)
 1. [Known limitations](#KnownLimitations)

<a name="Installation"></a>
## Installation

`JuliaApplications.jl` is NOT YET registered with Julia's **General** registry.
It can be installed using Julia's built-in package manager:

```julia
julia> ]
pkg> add https://github.com/ma-laforge/JuliaApplications.jl
```

<a name="KnownLimitations"></a>
## Known limitations

### Compatibility

Extensive compatibility testing of JuliaApplications.jl has not been performed.  The module has been tested using the following environment(s):

 - Linux / Julia-1.3.1

## Disclaimer

The JuliaApplications.jl module is not yet mature.  Expect significant changes.
