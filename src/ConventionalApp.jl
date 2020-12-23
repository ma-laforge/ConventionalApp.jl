#ConventionalApp: Develop conventional applications in Julia
#-------------------------------------------------------------------------------
module ConventionalApp

using Pkg
#using LibGit2

include("base.jl")
include("filegen.jl")
#include("install.jl")

export Project, setup_env, activeproject, @include_startup

end #ConventionalApp
