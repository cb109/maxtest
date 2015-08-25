fileIn "assert2.ms"
fileIn "finder_dircrawler.ms"
fileIn "runner_unittest.ms"
fileIn "presenter_interactive.ms"
fileIn "presenter_listener.ms"
fileIn "presenter_junitxml.ms"


/*
 *  Convenience entry point that provides defaults and can be customized
 *  by handing optional arguments to its only method run().
 */
struct maxtest
(
    function run directory
                 finder:#dircrawler
                 runner:#unittest
                 presenter:#interactive =
    (
        case finder of (
            (#dircrawler) : (finder = DirCrawler directory)
        )

        local tests = finder.getTests()

        case runner of (
            (#unittest) : (runner = RunnerUnittest tests)
        )
        local results = runner.getResults()

        case presenter of (
            (#listener)    : (presenter = PresenterListener results)
            (#interactive) : (presenter = PresenterInteractive results)
            (#junitxml)    : (presenter = PresenterJUnitXml results directory)

        )
        presenter.show()
    )
)

global maxtest = maxtest()


-- examplesdir = pathConfig.appendPath (pathConfig.removePathLeaf (getFileNamePath (getThisScriptFilename()))) @"examples"
-- maxtest.run examplesdir