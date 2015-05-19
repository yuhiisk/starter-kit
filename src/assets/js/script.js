(function(win, doc) {
  'use strict';
  var Test, test;
  Test = (function() {
    function Test() {
      this.initialize();
    }

    Test.prototype.initialize = function(name) {
      this.name = name != null ? name : 'Hello World!';
      return this.hello(this.name);
    };

    Test.prototype.hello = function(str) {
      return console.log(str);
    };

    return Test;

  })();
  return test = new Test();
})(window, window.document);
