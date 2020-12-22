module JuliaApplications

using Pkg
using LibGit2

include("base.jl")
include("filegen.jl")

export Project, run_app, setup_env, activeproject, @include_startup

end #JuliaApplications
