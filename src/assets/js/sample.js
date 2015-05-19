'use strict';
var Test;

Test = (function() {
  function Test() {}

  Test.prototype.contstructor = function() {
    this.initialize();
    return this.eventify();
  };

  Test.prototype.initialize = function() {};

  Test.prototype.eventify = function() {};

  return Test;

})();
