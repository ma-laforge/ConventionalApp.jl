#ConventionalApp: base type, constant & function definitions.
#-------------------------------------------------------------------------------


#==Main types
===============================================================================#
abstract type AbstractProject; end

struct ActiveProject <: AbstractProject; end
const activeproject = ActiveProject()

struct Project <: AbstractProject
	root::String
end
Project(m::Module) = Project(abspath(dirname(dirname(pathof(m)))))
Project(::ActiveProject) = Project(abspath(dirname(Base.load_path_expand("@"))))
#Project(repo::LibGit2.GitRepo) = Project(LibGit2.path(repo))


#==Extensions
===============================================================================#
Base.basename(proj::Project) = basename(proj.root)
Pkg.activate(p::Project) = Pkg.activate(p.root)


#==Display functions
===============================================================================#

"""
`displayenv()`

Display environment info.
"""
function displayenv()
	projpath = dirname(Base.load_path_expand("@"))
	@info("Project: $(basename(projpath))")
	map((path)->println("--> $path"), Base.load_path())
	println()
end
Base.show(::ActiveProject) = displayenv()


#==Top-level interface
===============================================================================#

"""
`@include_startup(proj::Project)`

`include` the `./startup.jl` file found in the `proj` directory. Should be
called from a global scope (not a function).

Implemented as macro to ensure `include` is run from calling scope.
"""
macro include_startup(proj)
	return quote begin #Create temp scope for startupfile variable
		local startupfile = joinpath($(esc(proj)).root, "startup.jl")
		if ispath(startupfile)
			$(__module__).include(startupfile)
		end
	end end
end

"""
`setup_env(proj::Project)`

Define a minmial environment stack and activates specified `Project`.
"""
function setup_env(proj::Project)
	empty!(Base.LOAD_PATH)
	push!(Base.LOAD_PATH, "@", "@stdlib")
	Pkg.activate(proj)
	return proj
end
setup_env(proj::ActiveProject) = setup_env(Project(proj))

#Last line
