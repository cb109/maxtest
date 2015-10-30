/*
 * A simple Logger class to write formatted message to both Listener
 * and standard output channels.
 *
 * The standard out is useful to get live feedback in calling processes
 * like a continuous integration software.
 *
 * The constructor accepts a name for the Logger instance and a default
 * output channel (#stdout|#stderr) as optional arguments.
 *
 */
struct MAXTestLogger
(
    public name_ = "maxtest",
    public defaultChannel = #stdout,

    private _cSharpCode = "
    using System;

    class StdOutPrinter {
        static public bool print(string txt) {
            Console.WriteLine(txt);
            return true;
        }
    }

    class StdErrPrinter {
        static public bool print(string txt) {
            Console.Error.WriteLine(txt);
            return true;
        }
    }
    ",


    private
    function createAssembly code className =
    (
        local provider = dotNetObject "Microsoft.CSharp.CSharpCodeProvider"
        local param = dotNetObject "System.CodeDom.Compiler.CompilerParameters"
        param.GenerateInMemory = on
        local compiled = provider.CompileAssemblyFromSource param #(code)
        compiled.CompiledAssembly.CreateInstance className
    ),


    private _stdout = createAssembly this._cSharpCode "StdOutPrinter",
    private _stderr = createAssembly this._cSharpCode "StdErrPrinter",


    private
    function _log text_ level channel:this.defaultChannel =
    (
        /*
         * <OkClass>_log <String>text_ <String>level [<Name>channel]
         * Write a message to the Listener and standard out/err.
         * Message is formatted using current time, logger name and text.
         */
        local message = StringStream ""
        format "% [%] %: %" localTime this.name_ level text_ to:message
        message = message as string
        case channel of
        (
            #stdout : (this._stdout.print message)
            #stderr : (this._stderr.print message)
            default : ()  -- Do nothing.
        )
        format "%\n" message
    ),


    public
    function debug text_ =
    (
        this._log text_ "DEBUG"
    ),


    public
    function info text_ =
    (
        this._log text_ "INFO"
    ),


    public
    function warn text_ =
    (
        this._log text_ "WARN"
    ),


    public
    function error text_ =
    (
        this._log text_ "ERROR"
    ),


    public
    function critical text_ =
    (
        this._log text_ "CRITICAL"
    )
)
