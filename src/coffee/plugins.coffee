((win, doc, $) ->

    kbns = win.kbns || {}

    # extend jQuery
    $.extend

        ###
        * wait
        ###
        wait: (duration) ->
            dfd = new $.Deferred()
            setTimeout(dfd.resolve, duration)
            return dfd


    # extend prototype
    # $.fn.extend

) window, window.document, jQuery
