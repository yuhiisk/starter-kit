//
// EventDispatcher
//
var EventDispatcher = (function () {
    function EventDispatcher() {
        this._events = {};
    }
    EventDispatcher.prototype.hasEventListener = function (eventName) {
        return !!this._events[eventName];
    };

    EventDispatcher.prototype.addEventListener = function (eventName, callback) {
        if (this.hasEventListener(eventName)) {
            var events = this._events[eventName];

            for (var i in events) {
                if (events[i] === callback) {
                    return;
                }
            }

            events.push(callback);
        } else {
            this._events[eventName] = [callback];
        }

        return this;
    };

    EventDispatcher.prototype.removeEventListener = function (eventName, callback) {
        if (!this.hasEventListener(eventName)) {
            return;
        } else {
            var events = this._events[eventName], i = events.length, index;

            while (i--) {
                if (events[i] === callback) {
                    index = i;
                }
            }

            events.splice(index, i);
        }

        return this;
    };

    EventDispatcher.prototype.fireEvent = function (eventName, opt_this) {
        if (!this.hasEventListener(eventName)) {
            return;
        } else {
            var events = this._events[eventName], copyEvents = this.merge([], events), arg = this.merge([], arguments);

            arg.splice(0, 2);

            for (var i in copyEvents) {
                copyEvents[i].apply(opt_this || this, arg);
            }
        }
    };

    EventDispatcher.prototype.merge = function (first, second) {
        var len = +second.length, j = 0, i = first.length;

        while (j < len) {
            first[i++] = second[j++];
        }

        // support IE<9
        if (len !== len) {
            while (second[j] !== undefined) {
                first[i++] = second[j++];
            }
        }

        first.length = i;

        return first;
    };
    return EventDispatcher;
})();
//# sourceMappingURL=EventDispatcher.js.map
