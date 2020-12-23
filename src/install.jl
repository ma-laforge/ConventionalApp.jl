#ConventionalApp: Install interface (deprecated).
#-------------------------------------------------------------------------------


#==Top-level interface
===============================================================================#

"""
`install(appurl::String, destpath::String)`

Download/install specified application (.git repository) to `destpath`.
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
