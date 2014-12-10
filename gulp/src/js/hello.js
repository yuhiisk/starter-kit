var Greeter = (function () {
    function Greeter(greeting) {
        this.greeting = greeting;
    }
    Greeter.prototype.greet = function () {
        return this.greeting;
    };
    return Greeter;
})();
;

var greeter = new Greeter('Hello, world!'), greetEl = document.createElement('div'), greetHeading = document.createElement('h2'), str = greeter.greet();

greetHeading.textContent = str;
greetEl.appendChild(greetHeading);
document.body.appendChild(greetEl);
//# sourceMappingURL=hello.js.map
