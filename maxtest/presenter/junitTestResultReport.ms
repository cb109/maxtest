/*
 *	Copyright (c) 2012, Pixelbaker
 *	All rights reserved.
 *
 *	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *		Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *		Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

(
	global PresenterJUnitTestResultReport
	struct PresenterJUnitTestResultReport
	(
		/*
			A presenter which outputs the test results in an "JUnit Test Result Report" format,
			which can be used by Hudson for instance.
		 */


		public inResults,
		public inFilepath,

		private _results,
		private _filepath,

		private _writer,
		private _settings,


		private
		function dispose =
		(
			(dotNetClass "System.GC").Collect()
			gc light:true
		),


		private
		function closeReport =
		(
			_writer.Flush()
			_writer.Close()

			dispose()
		),


		private
		function writeTests =
		(
			for resultOn in _results do (
				_writer.WriteStartElement "testcase"
				_writer.WriteAttributeString "classname" resultOn.structName
				_writer.WriteAttributeString "name" resultOn.testName

				case resultOn.state of (
					#Ok: ()
					#Failure: (
						_writer.WriteStartElement "failure"
						_writer.WriteAttributeString "type" "failure"
						_writer.WriteValue (resultOn.resultStream as String)
						_writer.WriteEndElement()
					)
					#Error: (
						_writer.WriteStartElement "error"
						_writer.WriteAttributeString "type" "error"
						_writer.WriteValue (resultOn.resultStream as String)
						_writer.WriteEndElement()
					)
					default: ()
				)

				_writer.WriteEndElement()
			)
		),


		private
		function initWriter =
		(
			local XmlWriter = DotNetClass "System.Xml.XmlWriter"
			_writer = XmlWriter.Create _filepath _settings
		),


		public
		function show =
		(
			initWriter()

			_writer.WriteStartDocument()
			_writer.WriteStartElement "testsuite"
			writeTests()
			_writer.WriteEndElement()
			_writer.WriteEndDocument()

			closeReport()
		),


		private
		function initSettings =
		(
			_settings = DotNetObject "System.Xml.XmlWriterSettings"
			_settings.Indent = true
			_settings.CloseOutput = true
		),


		on create do
		(
			if not isKindOf inResults Array then
				throw "No Array of MaxtestResult instances supplied on construction: " inResults

			if not isKindOf inFilepath String or not PathConfig.isLegalPath inFilepath then
				throw "No filepath specified on construction: " inFilepath

			_results = inResults
			_filepath = inFilepath

			initSettings()
		)
	)
)