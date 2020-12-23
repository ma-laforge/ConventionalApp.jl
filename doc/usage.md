# ConventionalApp: Usage

<a name="Installing_Application"></a>
## Installing an application

Use the Julia `Pkg` system to download & install your `ConventionalApp`-enabled application.
For example, to try out the sample application:

```julia-repl
julia> ]
pkg> add https://github.com/ma-laforge/SampleConventionalApp.jl
```

<a name="Installing_bashscript"></a>
### Creating a `bash` launch script (unix/linux/...)

Launcher files must be generated on the user's computer to ensure the `julia` command can be located.
A launcher `bash` script can be generated with the following:

```julia-repl
using SampleConventionalApp
using ConventionalApp
ConventionalApp.gen_bashfile(SampleConventionalApp)
```
(Substituting `SampleConventionalApp` with the name of your own application/project)

<a name="Installing_winshortcut"></a>
### Creating a Windows shortcut

Windows shortcuts must be generated on the user's computer to ensure the `julia` command can be located.
A windows shortcut can be generated with the following:

```julia-repl
using SampleConventionalApp
using ConventionalApp
ConventionalApp.gen_winshortcut(SampleConventionalApp)
```

(Substituting `SampleConventionalApp` with the name of your own application/project)

IMPORTANT: At the moment, this will only generate instructions on how to create your shortcut
(will explain what goes in the "Target", and "Start in" fields).

<a name="Using_ConventionalApp"></a>
## Using `ConventionalApp` in your application

The first step to using `ConventionalApp` facilities in an application is to `add`
`ConventionalApp` to its `Project.toml` file:

```julia-repl
julia> ]
pkg> activate MyApplication

pkg> add ConventionalApp
```

<a name="add_run_app"></a>
### Add `run_app()` function

`ConventionalApp` expects that the entry point of your application be a `run_app()`
function in your application's main module (same name as your application).
In other words, the role of `run_app()` is similar to that of `main()` in c/c++.
The `ConventionalApp` launch script will therefore automatically execute:

```julia-repl
MyApplication.run_app()
```

(Substituting `MyApplication` with the name of your own application/project)

<a name="add_run_jl"></a>
### Add `run.jl` file

The following will create a Julia launch script (`run.jl`) in your application's root:

```julia-repl
using MyApplication
using ConventionalApp
ConventionalApp.gen_runfile(MyApplication)
```

IMPORTANT: You must commit this `run.jl` file to make it available to others.

<a name="add_startup_jl"></a>
### Add `startup.jl` file

If you wish to add code that is only executed on startup (when `run.jl` is executed),
add it the (optional) `startup.jl` file located in the root directory of your application/project.
