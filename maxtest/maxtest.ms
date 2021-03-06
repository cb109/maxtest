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
    public
    function run directory
        finder:#dircrawler
        key:undefined
        runner:#unittest
        presenter:#interactive
        xmlfile:undefined =
    (
        case finder of (
            (#dircrawler) : (finder = DirCrawler directory key:key)
        )
        local tests = finder.getTests()

        case runner of (
            (#unittest) : (runner = RunnerUnittest tests)
        )
        local results = runner.getResults()

        case presenter of (
            (#listener)    : (presenter = PresenterListener results)
            (#interactive) : (presenter = PresenterInteractive results)
            (#junitxml)    : (
                if xmlfile == undefined do
                    throw "maxtest: You must set an xmlfile when using JUnit output."
                presenter = PresenterJUnitXml results xmlfile
            )

        )
        presenter.show()
    )
)

global maxtest = maxtest()


-- examplesdir = pathConfig.appendPath (pathConfig.removePathLeaf (getFileNamePath (getThisScriptFilename()))) "examples"
-- maxtest.run examplesdir key:"not fail"
-- maxtest.run examplesdir presenter:#listener
-- maxtest.run examplesdir presenter:#junitxml xmlfile:(pathConfig.appendPath examplesdir "maxtest.xml")
