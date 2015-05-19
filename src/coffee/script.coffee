do (win = window, doc = window.document) ->

    'use strict'

    class Test

        constructor: ->
            @initialize()

        initialize: (@name = 'Hello World!') ->
            @hello(@name)

        hello: (str) ->
            console.log(str)

    test = new Test()
