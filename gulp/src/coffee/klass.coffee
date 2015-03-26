class Klass

    constructor: (@name = 'Klass') ->

    initialize: () ->
        console.log 'initialize template.'

    say: () ->
        return "Hello, #{@name}!"

module.exports = Klass
