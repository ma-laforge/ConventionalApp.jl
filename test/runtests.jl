using Test, JuliaApplications

#printsep(label, sep="-") = println("\n", label, "\n", repeat(sep, 80))
#printheader(label) = printsep(label, "=")

function show_testset_section()
	println()
	@info "SECTION: " * Test.get_testset().description * "\n" * repeat("=", 80)
end

function show_testset_description()
	@info "Testing: " * Test.get_testset().description
end

@testset "JuliaApplications tests" begin
	testfiles = ["test1.jl", "test2.jl"]

	for testfile in testfiles
#		include(testfile)
	end

	@test 1 == 1

end #testset

:Test_Complete
