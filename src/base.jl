#JuliaApplications: base type, constant & function definitions.


abstract type AbstractProject; end

struct ActiveProject <: AbstractProject; end
const activeproject = ActiveProject()

struct Project <: AbstractProject
	root::String
end
Project(m::Module) = Project(abspath(dirname(dirname(pathof(m)))))
Project(::ActiveProject) = Project(abspath(dirname(Base.load_path_expand("@"))))
Project(repo::LibGit2.GitRepo) = Project(LibGit2.path(repo))


#Extend Pkg.activate:
Pkg.activate(p::Project) = Pkg.activate(p.root)

macro include_startup(proj)
	return quote begin #Create temp scope for startupfile variable
		local startupfile = joinpath($(esc(proj)).root, "startup.jl")
		if ispath(startupfile)
			$(__module__).include(startupfile)
		end
	end end
end



function setup_env(proj::Project)
	empty!(Base.LOAD_PATH)
	push!(Base.LOAD_PATH, "@", "@stdlib")
	Pkg.activate(proj)
	return proj
end
setup_env(proj::ActiveProject) = setup_env(Project(proj))

#=
function run_app(proj::Project)
	modname = basename(proj.root)
	appsrc = joinpath(proj.root, "src", modname * ".jl")
	modsymbol = :($modname)

	!isdefined(Main, modsymbol)
		include(appsrc)
	end
	m = eval(:($modname))
	m.run_app()
	return m
end
run_app(proj::ActiveProject) = run_app(Project(proj))
=#

"""
`install(appurl::String, destpath::String)`

Download/install application (.git repository).
"""
function install(appurl::String, destpath::String)
	@info("Cloning $appurl...")
	println()
	repo = LibGit2.clone(appurl, destpath)
	proj = Project(LibGit2.path(repo))
	return proj
end

#TODO: Install in pwd() by default??
#install(appurl::String) = install(appurl, pwd())

"""
`update!(repo::LibGit2.GitRepo)`

Update application code (.git repository).
"""
function update!(repo::LibGit2.GitRepo)
	LibGit2.fetch(repo)
	LibGit2.merge!(repo)
end

"""
update_repo!(proj::Project)

Update application code (.git repository).
More explicit name than `update!()` to minimize accidental use.
"""
function update_repo!(proj::Project)
	repo = LibGit2.GitRepo(proj.root)
end


#Display environment info:
function displayenv()
	projpath = dirname(Base.load_path_expand("@"))
	@info("Project: $(basename(projpath))")
	map((path)->println("--> $path"), Base.load_path())
	println()
end
Base.show(::ActiveProject) = displayenv()


#Last line
