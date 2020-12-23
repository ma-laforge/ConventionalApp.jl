#ConventionalApp: Launcher file generation
#-------------------------------------------------------------------------------


#==Constants
===============================================================================#
#const DEFAULT_JULIACMD="julia" #Do not use: Will not exist on most systems
const BASHSCRIPT_PATH="\$SCRIPTDIR"
const RUNSCRIPT_JULIA="run.jl"
#const RUNSCRIPT_BASH="run"


#==String generators
===============================================================================#
function gen_juliacmd()
	#Base.julia_cmd() #TODO: Investigate use of julia_cmd() instead.
	juliacmd = joinpath(Sys.BINDIR, Base.julia_exename())
	return juliacmd
end

function gen_runfile(::Type{String}, proj::Project)
	app_path = proj.root
	app_name = basename(app_path)
	runfile="""
using ConventionalApp

proj = Project(@__DIR__)
setup_env(proj)
@include_startup(proj)

#show(activeproject)

Main.include("src/$app_name.jl")
Main.$app_name.run_app()
"""
end

function gen_bashfile(::Type{String}, juliacmd::String, projpath::String)
	bashfile="""
#!/bin/bash
SCRIPTPATH=`readlink -f \$0` #This file here
SCRIPTDIR=`dirname \$SCRIPTPATH`

PROJPATH="$projpath"
JULIASCRIPT="\$PROJPATH/$RUNSCRIPT_JULIA"
JULIACMD="$juliacmd"
exec \$JULIACMD -i --color=yes --startup-file=no --project="\$PROJPATH" "\$JULIASCRIPT" "\$@"
"""
	return bashfile
end

function gen_winshortcut(::Type{String}, juliacmd::String, projpath::String)
	info="""
Target:
   \"$juliacmd\" --project=\"$projpath\" -L \"$RUNSCRIPT_JULIA\"

Start in:
    \"$projpath\"
"""
	return info
end


#==File generators (implementation)
===============================================================================#
function _gen_runfile(proj::Project)
	filepath = joinpath(proj.root, RUNSCRIPT_JULIA)
	data = gen_runfile(String, proj)
	open(filepath, "w") do io
		print(io, data)
	end
	return
end

function _gen_bashfile(proj::Project, bashfile::String)
	inprojroot = false
	projpath = inprojroot ? BASHSCRIPT_PATH : proj.root

	data = gen_bashfile(String, gen_juliacmd(), projpath)
	open(bashfile, "w") do io
		print(io, data)
	end
	return
end
_gen_bashfile(proj::Project, bashfile::Nothing) = _gen_bashfile(proj, basename(proj))

function _gen_winshortcut(proj::Project, bashfile::String)
	data = gen_winshortcut(String, gen_juliacmd(), proj.root)
	println()
	@info("To create a Windows shortcut, use the following values:")
	println(data)
	return
end
_gen_winshortcut(proj::Project, bashfile::Nothing) = _gen_winshortcut(proj, basename(proj) * ".lnk")


#==Top-level interface
===============================================================================#
gen_runfile(proj::Project) = _gen_runfile(proj)
gen_runfile(m::Module) = _gen_runfile(Project(m))

gen_bashfile(proj::Project, bashfile=nothing) = _gen_bashfile(proj, bashfile)
gen_bashfile(m::Module, bashfile=nothing) = _gen_bashfile(Project(m), bashfile)

gen_winshortcut(proj::Project, bashfile=nothing) = _gen_winshortcut(proj, bashfile)
gen_winshortcut(m::Module, bashfile=nothing) = _gen_winshortcut(Project(m), bashfile)

#Last line
