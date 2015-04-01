((win, doc) ->

    'use strict'

    class Test extends EventDispatcher

        constructor: () ->
            @initialize()

        initialize: () ->
            EventDispatcher.call(@)

        say: (str) ->
            @fireEvent('say')

        done: () ->
            @fireEvent('done', @, ['done!done!done!'])

    test = new Test()
    test.addEventListener('say', () ->
        console.log 'fire say()'
    )
    test.addEventListener('done', (e) ->
        console.log 'fire done()', e
    )

    test.say()
    test.done()

) window, window.document
