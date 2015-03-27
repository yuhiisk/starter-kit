'use strict';
var EventDispatcher;

EventDispatcher = (function() {
  function EventDispatcher() {
    this._events = {};
  }

  EventDispatcher.prototype.hasEventListener = function(eventName) {
    return !!this._events[eventName];
  };

  EventDispatcher.prototype.addEventListener = function(eventName, callback) {
    var events, i, _i, _len;
    if (this.hasEventListener(eventName)) {
      events = this._events[eventName];
      for (_i = 0, _len = events.length; _i < _len; _i++) {
        i = events[_i];
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

  EventDispatcher.prototype.removeEventListener = function(eventName, callback) {
    var events, i, index;
    if (!this.hasEventListener(eventName)) {
      return;
    } else {
      events = this._events[eventName];
      i = events.length;
      index = 0;
      while (i--) {
        if (events[i] === callback) {
          index = i;
        }
      }
      events.splice(index, i);
    }
    return this;
  };

  EventDispatcher.prototype.fireEvent = function(eventName, opt_this) {
    var arg, copyEvents, events, i, _i, _len, _results;
    if (!this.hasEventListener(eventName)) {

    } else {
      events = this._events[eventName];
      copyEvents = this.merge([], events);
      arg = this.merge([], arguments);
      arg.splice(0, 2);
      _results = [];
      for (_i = 0, _len = copyEvents.length; _i < _len; _i++) {
        i = copyEvents[_i];
        _results.push(copyEvents[i].apply(opt_this || this, arg));
      }
      return _results;
    }
  };

  EventDispatcher.prototype.merge = function(first, second) {
    var i, j, len;
    len = +second.length;
    j = 0;
    i = first.length;
    while (j < len) {
      first[i++] = second[j++];
    }
    if (len !== len) {
      while (second[j] !== void 0) {
        first[i++] = second[j++];
      }
    }
    first.length = i;
    return first;
  };

  return EventDispatcher;

})();

module.exports = EventDispatcher;
