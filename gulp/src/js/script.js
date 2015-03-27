(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var EventDispatcher, Klass;

Klass = require('./klass');

EventDispatcher = require('./EventDispatcher');

(function(win, doc) {
  'use strict';
  var obj;
  obj = new Klass('world');
  return console.log(obj.say());
})(window, window.document);



},{"./EventDispatcher":2,"./klass":3}],2:[function(require,module,exports){
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
    var events, i, k, len1;
    if (this.hasEventListener(eventName)) {
      events = this._events[eventName];
      for (k = 0, len1 = events.length; k < len1; k++) {
        i = events[k];
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
    var arg, copyEvents, events, i, k, len1, results;
    if (!this.hasEventListener(eventName)) {

    } else {
      events = this._events[eventName];
      copyEvents = this.merge([], events);
      arg = this.merge([], arguments);
      arg.splice(0, 2);
      results = [];
      for (k = 0, len1 = copyEvents.length; k < len1; k++) {
        i = copyEvents[k];
        results.push(copyEvents[i].apply(opt_this || this, arg));
      }
      return results;
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



},{}],3:[function(require,module,exports){
var Klass;

Klass = (function() {
  function Klass(name) {
    this.name = name != null ? name : 'Klass';
  }

  Klass.prototype.initialize = function() {
    return console.log('initialize template.');
  };

  Klass.prototype.say = function() {
    return "Hello, " + this.name + "!";
  };

  return Klass;

})();

module.exports = Klass;



},{}]},{},[1]);
