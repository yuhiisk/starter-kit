Klass = require './klass'
EventDispatcher = require './EventDispatcher'

((win, doc) ->

    'use strict'

    obj = new Klass('world')
    console.log obj.say()
    console.log new EventDispatcher()

) window, window.document
