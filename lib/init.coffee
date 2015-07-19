module.exports =
    config:
        phpExecutablePath:
            type: 'string'
            default: ''
            title: 'PHP Executable Path'
        phpAnalyserPath:
            type: 'string'
            default: ''
            title: 'PHP-Analyser Path'
        phpAnalyserDetections:
            type: 'string'
            default: '--detect-all'
            title: 'Analyser detection options (separated by space)'

    activate: ->
        console.log 'activate php-analyser'
