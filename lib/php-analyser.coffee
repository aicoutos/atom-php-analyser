linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
{CompositeDisposable} = require 'atom'

class PhpAnalyser extends Linter
    # The syntax that the linter handles. May be a string or
    # list/tuple of strings. Names should be all lowercase.
    @syntax: ['text.html.php', 'source.php']

    # A string, list, tuple or callable that returns a string, list or tuple,
    # containing the command line (with arguments) used to lint.
    cmd: null

    executablePath: null

    linterName: 'PHP Analyser'

    # A regex pattern used to extract information from the executable's output.
    regex: '(?<message>.+?) on line (?<line>\\d+)'

    constructor: (editor) ->
        super(editor)
        @disposables = new CompositeDisposable

        analyser_path = null
        analyser_options = null

        @disposables.add atom.config.observe 'php-analyser.phpExecutablePath', =>
            @executablePath = atom.config.get 'php-analyser.phpExecutablePath'
        @disposables.add atom.config.observe 'php-analyser.phpAnalyserPath', =>
            analyser_path = atom.config.get 'php-analyser.phpAnalyserPath'
        @disposables.add atom.config.observe 'phpAnalyserDetections', =>
            analyser_options = atom.config.get 'php-analyser.phpAnalyserDetections'

        @cmd = 'php ' + analyser_path + '/php-analyser.php ' + analyser_options
        console.log @cmd

    destroy: ->
        super
        @disposables.dispose()

    createMessage: (match) ->
        # message might be empty, we have to supply a value
        if not match.errorType
            match.warning = true
        else
            match.error = true

        super(match)

module.exports = PhpAnalyser
