var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

(function(win, doc) {
  'use strict';
  var Test, test;
  Test = (function(_super) {
    __extends(Test, _super);

    function Test() {
      this.initialize();
    }

    Test.prototype.initialize = function() {
      return EventDispatcher.call(this);
    };

    Test.prototype.say = function(str) {
      return this.fireEvent('say');
    };

    Test.prototype.done = function() {
      return this.fireEvent('done', this, ['done!done!done!']);
    };

    return Test;

  })(EventDispatcher);
  test = new Test();
  test.addEventListener('say', function() {
    return console.log('fire say()');
  });
  test.addEventListener('done', function(e) {
    return console.log('fire done()', e);
  });
  test.say();
  return test.done();
})(window, window.document);
