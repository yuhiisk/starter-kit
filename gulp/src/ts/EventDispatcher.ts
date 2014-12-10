//
// EventDispatcher
//

class EventDispatcher {
  _events: any;
  constructor() {
    this._events = {};
  }

  hasEventListener(eventName) {
    return !!this._events[eventName];
  }

  addEventListener(eventName, callback) {
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
  }

  removeEventListener(eventName, callback) {
    if (!this.hasEventListener(eventName)) {
      return;
    } else {
      var events = this._events[eventName],
        i = events.length,
        index;

      while (i--) {
        if (events[i] === callback) {
          index = i;
        }
      }

      events.splice(index, i);
    }

    return this;
  }

  fireEvent(eventName, opt_this) {
    if (!this.hasEventListener(eventName)) {
      return;
    } else {
      var events = this._events[eventName],
        copyEvents = this.merge([], events),
        arg = this.merge([], arguments);

      arg.splice(0, 2);

      for (var i in copyEvents) {
        copyEvents[i].apply(opt_this || this, arg);
      }
    }
  }

  merge(first, second) {
    var len = +second.length,
      j = 0,
      i = first.length;

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
  }
}

