#
#  EventDispatcher
#
'use strict'

class EventDispatcher

    constructor: () ->
        @_events = {}

    hasEventListener: (eventName) ->
        return !!this._events[eventName]

    addEventListener: (eventName, callback) ->
        if @hasEventListener(eventName)
            events = @_events[eventName]

            for i in events
                if events[i] is callback
                    return

            events.push(callback)
        else
            @_events[eventName] = [callback]

        @

    removeEventListener: (eventName, callback) ->
        if !@hasEventListener(eventName)
            return
        else
            events = this._events[eventName]
            i = events.length
            index = 0

            while i--
                if events[i] is callback
                    index = i

            events.splice(index, i)

        @

    fireEvent: (eventName, opt_this) ->
        if !this.hasEventListener(eventName)
            return
        else
            events = @_events[eventName]
            copyEvents = @merge([], events)
            arg = @merge([], arguments)

            arg.splice(0, 2)

            for i in copyEvents
                copyEvents[i].apply(opt_this || @, arg)

    merge: (first, second) ->
        len = +second.length
        j = 0
        i = first.length

        while j < len
            first[i++] = second[j++]

        # support IE<9
        if len isnt len
            while second[j] isnt undefined
                first[i++] = second[j++]

        first.length = i

        return first


module.exports = EventDispatcher
