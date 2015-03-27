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
