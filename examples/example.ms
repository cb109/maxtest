fileIn @"assert.ms"
fileIn @"finder.ms"
fileIn @"runner.ms"
fileIn @"presenter.ms"


(
	local currentFilepath = getFilenamePath (getSourceFileName())
	
	-- Gather different finders
	local finders = #()
	append finders (DirCrawler currentFilepath)
	

	-- Run all finders
	local tests = #()
	for finderOn in finders do tests += finderOn.getTests()

	-- Execute runner
	local testRunner = Runner tests
	local results = testRunner.getResults()	

	-- Display results
	local presenter = PresenterListener results
	presenter.show()
)