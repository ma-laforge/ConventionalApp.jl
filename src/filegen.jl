#JuliaApplications


function gen_runfile(::Type{String}, proj::Project)
	app_path = proj.root
	app_name = basename(app_path)
	runfile="""
using JuliaApplications

proj = Project(@__DIR__)
setup_env(proj)
@include_startup(proj)

show(activeproject)

Main.include("src/$app_name.jl")
Main.ConvApp.run_app()
"""
end


function gen_bashfile(::Type{String}, proj::Project)
	app_path = proj.root
	#Base.julia_cmd() #TODO: Investigate use of julia_cmd() instead.
	jpath = joinpath(Sys.BINDIR, Base.julia_exename())
	spath = joinpath(app_path, "run.jl")

	bashfile="""
#!/bin/bash

PROJPATH="$app_path"
SCRIPTPATH="$spath"
JULIABINPATH="$jpath"
exec \$JULIABINPATH -i --color=yes --startup-file=no --project="\$PROJPATH" "\$SCRIPTPATH" "\$@"
"""

	return bashfile
end


function gen_runfile(proj::Project)
end


gen_bashfile(::Type{String}, m::Module) = gen_bashfile(String, Project(m))


#Last line
