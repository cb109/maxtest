(
	local currentFilepath = getFilenamePath (getSourceFileName())
	local rootDir = pathConfig.removePathLeaf currentFilepath
	local sourceDir = pathConfig.appendPath rootDir "maxtest"

	fileIn (pathConfig.appendPath sourceDir @"assert2.ms")
	fileIn (pathConfig.appendPath sourceDir @"finder_dircrawler.ms")
	fileIn (pathConfig.appendPath sourceDir @"runner_unittest.ms")
	fileIn (pathConfig.appendPath sourceDir @"presenter_interactive.ms")


	-- Gather different finders
	local finders = #()
	append finders (::DirCrawler currentFilepath)

	-- Run all finders
	local tests = #()
	for finderOn in finders do tests += finderOn.getTests()

	-- Execute runner
	local testRunner = ::RunnerUnittest tests
	local results = testRunner.getResults()

	-- Display results
	local presenter = ::PresenterInteractive results
	presenter.show()
)