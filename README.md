<!-- Reference-style links to make tables & lists more readable -->
[SampleConventionalApp]: <https://github.com/ma-laforge/SampleConventionalApp.jl>


# ConventionalApp.jl

[![Build Status](https://github.com/ma-laforge/ConventionalApp.jl/workflows/CI/badge.svg)](https://github.com/ma-laforge/ConventionalApp.jl/actions?query=workflow%3ACI)

Provides tools to help deploy/execute conventional applications in Julia.

<a name="Background"></a>
## Background
Julia "Project Environments" define the set of packages to use for experimentation within particular problem spaces. The Julia flow therefore encourages users to `activate` a project environment and use problem-specific "scripts" to run their experiments.

By design, project environments are meant for somewhat open, "interactive" explorations (i.e. assemble custom analyses, as needed).

In comparison, conventional applications tend to run specific code when launched. ConventionalApp.jl therefore provides tools to help configure the Julia environment, and launch said code.

## Table of contents

 1. [Background](#Background)
 1. [Installation](#Installation)
 1. [Usage](doc/usage.md)
    1. [Installing an application](doc/usage.md#Installing_Application)
       1. [Creating a `bash` launch script](doc/usage.md#Installing_bashscript)
       1. [Creating a Windows shortcut](doc/usage.md#Installing_winshortcut)
    1. [Using `ConventionalApp` in your application](doc/usage.md#Using_ConventionalApp)
       1. [Add `run_app()` function](doc/usage.md#add_run_app)
       1. [Add `run.jl` file](doc/usage.md#add_run_jl)
       1. [Add `startup.jl` file](doc/usage.md#add_startup_jl)
 1. [Sample application](#SampleApplication)
 1. [Known limitations](#KnownLimitations)
    1. [TODO](#TODO)

<a name="Installation"></a>
## Installation

`ConventionalApp.jl` is registered with Julia's **General** registry.
It can be installed using Julia's built-in package manager:


```julia-repl
julia> ]
pkg> add ConventionalApp
```

<a name="SampleApplication"></a>
## Sample application
See [SampleConventionalApp].

<a name="KnownLimitations"></a>
## Known limitations

<a name="TODO"></a>
### TODO

 - Generate windows shortcuts instead of displaying instructions.
 - Add windows shortcut to start menu from application build script.
 - Add `bash` launcher to `/usr/local/bin` (or something) from build script if user has permissions.
 - Maybe lanunchers could be saved to `~/.juliaapps/bin` and user could add that to path?

### Compatibility

Extensive compatibility testing of ConventionalApp.jl has not been performed.  The module has been tested using the following environment(s):

 - Windows 10 / Linux / Julia-1.5.3

## Disclaimer

The ConventionalApp.jl module is not yet mature.  Expect significant changes.
