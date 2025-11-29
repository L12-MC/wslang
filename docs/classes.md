# Classes and Objects

Classes allow you to create custom data types with properties and methods.

## Defining a Class

Use the `class` keyword to define a class:

```
>> class Person
... end
> Class Person defined
```

## Creating Objects

Create an instance of a class using the `new` keyword:

```
>> person1 = new Person()
> person1 = Person instance
```

## Class Properties

### Defining Properties

Define properties in the class definition:

```
>> class Person
... name = ""
... age = 0
... end
> Class Person defined
```

### Setting Properties

Set properties on an object instance:

```
>> person1 = new Person()
>> person1.name = "Alice"
> person1.name = "Alice"
>> person1.age = 30
> person1.age = 30.0
```

### Getting Properties

Access properties using dot notation:

```
>> print(person1.name)
Alice
>> print(person1.age)
30.0
```

## Class Methods

### Defining Methods

Define methods inside a class:

```
>> class Person
... name = ""
... age = 0
... def greet()
... print("Hello, my name is " + this.name)
... end
... end
> Class Person defined
```

### Calling Methods

Call methods on an object instance:

```
>> person1 = new Person()
>> person1.name = "Alice"
>> person1.greet()
Hello, my name is Alice
```

## Constructor

### Defining a Constructor

Use the `init` method as a constructor:

```
>> class Person
... def init(name, age)
... this.name = name
... this.age = age
... end
... def greet()
... print("Hello, I'm " + this.name + " and I'm " + this.age + " years old")
... end
... end
> Class Person defined
```

### Using the Constructor

```
>> person1 = new Person("Alice", 30)
> person1 = Person instance
>> person1.greet()
Hello, I'm Alice and I'm 30 years old
```

## The `this` Keyword

Use `this` to refer to the current instance:

```
>> class Counter
... count = 0
... def increment()
... this.count = this.count + 1
... end
... def getCount()
... print(this.count)
... end
... end
> Class Counter defined
>> counter = new Counter()
>> counter.increment()
>> counter.increment()
>> counter.getCount()
2.0
```

## Class Examples

### Rectangle Class

```
>> class Rectangle
... def init(width, height)
... this.width = width
... this.height = height
... end
... def area()
... result = this.width * this.height
... print("Area: " + result)
... end
... def perimeter()
... result = 2 * (this.width + this.height)
... print("Perimeter: " + result)
... end
... end
> Class Rectangle defined
>> rect = new Rectangle(5, 10)
>> rect.area()
Area: 50.0
>> rect.perimeter()
Perimeter: 30.0
```

### Bank Account Class

```
>> class BankAccount
... def init(owner, balance)
... this.owner = owner
... this.balance = balance
... end
... def deposit(amount)
... this.balance = this.balance + amount
... print("Deposited " + amount + ". New balance: " + this.balance)
... end
... def withdraw(amount)
... if amount <= this.balance
... this.balance = this.balance - amount
... print("Withdrew " + amount + ". New balance: " + this.balance)
... else
... print("Insufficient funds")
... end
... end
... def getBalance()
... print("Balance: " + this.balance)
... end
... end
> Class BankAccount defined
>> account = new BankAccount("Alice", 1000)
>> account.getBalance()
Balance: 1000.0
>> account.deposit(500)
Deposited 500.0. New balance: 1500.0
>> account.withdraw(200)
Withdrew 200.0. New balance: 1300.0
```

### Circle Class

```
>> class Circle
... def init(radius)
... this.radius = radius
... this.pi = 3.14159
... end
... def area()
... result = this.pi * this.radius * this.radius
... print("Area: " + result)
... end
... def circumference()
... result = 2 * this.pi * this.radius
... print("Circumference: " + result)
... end
... def diameter()
... result = 2 * this.radius
... print("Diameter: " + result)
... end
... end
> Class Circle defined
>> circle = new Circle(5)
>> circle.area()
Area: 78.53975
>> circle.circumference()
Circumference: 31.4159
>> circle.diameter()
Diameter: 10.0
```

### Student Class

```
>> class Student
... def init(name, grade)
... this.name = name
... this.grade = grade
... this.scores = []
... end
... def addScore(score)
... append(this.scores, score)
... print("Score added: " + score)
... end
... def average()
... if length(this.scores) == 0
... print("No scores yet")
... else
... sum = 0
... for i in range(0, length(this.scores))
... sum = sum + this.scores[i]
... end
... avg = sum / length(this.scores)
... print("Average: " + avg)
... end
... end
... def info()
... print("Student: " + this.name + ", Grade: " + this.grade)
... end
... end
> Class Student defined
>> student = new Student("Bob", 10)
>> student.info()
Student: Bob, Grade: 10.0
>> student.addScore(85)
Score added: 85.0
>> student.addScore(90)
Score added: 90.0
>> student.addScore(78)
Score added: 78.0
>> student.average()
Average: 84.33333333333333
```

## Multiple Objects

Create multiple instances of the same class:

```
>> class Dog
... def init(name, breed)
... this.name = name
... this.breed = breed
... end
... def bark()
... print(this.name + " says: Woof!")
... end
... end
> Class Dog defined
>> dog1 = new Dog("Max", "Labrador")
>> dog2 = new Dog("Bella", "Poodle")
>> dog1.bark()
Max says: Woof!
>> dog2.bark()
Bella says: Woof!
```

## Object Interaction

Objects can interact with each other:

```
>> class Point
... def init(x, y)
... this.x = x
... this.y = y
... end
... def distance(other)
... dx = this.x - other.x
... dy = this.y - other.y
... dist = sqrt(dx * dx + dy * dy)
... print("Distance: " + dist)
... end
... end
> Class Point defined
>> p1 = new Point(0, 0)
>> p2 = new Point(3, 4)
>> p1.distance(p2)
Distance: 5.0
```

## Best Practices

1. **Use meaningful class names**: Class names should be nouns and describe what they represent
2. **Initialize in constructor**: Use the `init` method to set up initial state
3. **Use `this` for clarity**: Always use `this` to access instance properties
4. **Encapsulate behavior**: Keep related data and operations together
5. **Create multiple instances**: Design classes to be reusable
6. **Keep methods focused**: Each method should do one thing well
