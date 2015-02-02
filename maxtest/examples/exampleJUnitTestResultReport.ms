(
	local currentFilepath = getFilenamePath (getSourceFileName())
	
	fileIn (currentFilepath + @"..\assert.ms")
	fileIn (currentFilepath + @"..\finder.ms")
	fileIn (currentFilepath + @"..\runner.ms")
	fileIn (currentFilepath + @"..\presenter\junitTestResultReport.ms")
	
	
	-- Gather different finders
	local finders = #()
	append finders (::DirCrawler currentFilepath)
	

	-- Run all finders
	local tests = #()
	for finderOn in finders do tests += finderOn.getTests()

	-- Execute runner
	local testRunner = ::Runner tests
	local results = testRunner.getResults()	

	-- Display results
	local presenter = ::PresenterJUnitTestResultReport \
		inResults:results \
		inFilepath:(currentFilepath + @"junitTestResultReport.xml")
	
	presenter.show()
)