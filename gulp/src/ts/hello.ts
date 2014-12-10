class Greeter {
	constructor(public greeting: string) {}
	greet() {
		return this.greeting;
	}
};

var greeter = new Greeter('Hello, world!'),
    greetEl = document.createElement('div'),
    greetHeading = document.createElement('h2'),
    str = greeter.greet();

greetHeading.textContent = str;
greetEl.appendChild(greetHeading);
document.body.appendChild(greetEl);

