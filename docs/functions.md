# Functions

Functions allow you to encapsulate reusable code blocks with parameters.

## Defining Functions

Use the `def` keyword to define a function:

```
>> def greet(name)
... print("Hello, " + name + "!")
... end
> Function greet defined
```

## Calling Functions

Call a function by its name with arguments in parentheses:

```
>> greet("Alice")
Hello, Alice!
```

## Function Parameters

### Single Parameter

```
>> def square(x)
... result = x * x
... print(result)
... end
> Function square defined
>> square(5)
25.0
```

### Multiple Parameters

```
>> def add(a, b)
... sum = a + b
... print(sum)
... end
> Function add defined
>> add(10, 20)
30.0
```

### No Parameters

```
>> def sayHello()
... print("Hello, World!")
... end
> Function sayHello defined
>> sayHello()
Hello, World!
```

## Function Examples

### Calculate Area of Rectangle

```
>> def area(width, height)
... result = width * height
... print("Area: " + result)
... end
> Function area defined
>> area(5, 10)
Area: 50.0
```

### Temperature Converter

```
>> def celsiusToFahrenheit(celsius)
... fahrenheit = (celsius * 9 / 5) + 32
... print(fahrenheit)
... end
> Function celsiusToFahrenheit defined
>> celsiusToFahrenheit(0)
32.0
>> celsiusToFahrenheit(100)
212.0
```

### Check Even or Odd

```
>> def checkEvenOdd(num)
... if num % 2 == 0
... print("Even")
... else
... print("Odd")
... end
... end
> Function checkEvenOdd defined
>> checkEvenOdd(4)
Even
>> checkEvenOdd(7)
Odd
```

### Calculate Factorial

```
>> def factorial(n)
... result = 1
... for i in range(1, n + 1)
... result = result * i
... end
... print(result)
... end
> Function factorial defined
>> factorial(5)
120.0
>> factorial(6)
720.0
```

### Find Maximum of Two Numbers

```
>> def max(a, b)
... if a > b
... print(a)
... else
... print(b)
... end
... end
> Function max defined
>> max(10, 20)
20.0
>> max(50, 30)
50.0
```

## Variable Scope

Variables defined inside a function are local to that function:

```
>> def test()
... local = 100
... print(local)
... end
> Function test defined
>> test()
100.0
```

Function parameters are also local:

```
>> def multiply(x, y)
... product = x * y
... print(product)
... end
> Function multiply defined
>> multiply(5, 6)
30.0
```

## Using Global Variables

Functions can access and modify global variables:

```
>> counter = 0
> counter = 0.0
>> def increment()
... counter = counter + 1
... print(counter)
... end
> Function increment defined
>> increment()
1.0
>> increment()
2.0
```

## Nested Function Calls

Functions can call other functions:

```
>> def double(x)
... result = x * 2
... print(result)
... end
> Function double defined
>> def quadruple(x)
... temp = x * 2
... double(temp)
... end
> Function quadruple defined
>> quadruple(5)
20.0
```

## Complex Function Example

### Calculate Circle Properties

```
>> def circleInfo(radius)
... pi = 3.14159
... area = pi * radius * radius
... circumference = 2 * pi * radius
... print("Radius: " + radius)
... print("Area: " + area)
... print("Circumference: " + circumference)
... end
> Function circleInfo defined
>> circleInfo(5)
Radius: 5.0
Area: 78.53975
Circumference: 31.4159
```

### Grade Calculator

```
>> def calculateGrade(score)
... if score >= 90
... print("Grade: A")
... else
... if score >= 80
... print("Grade: B")
... else
... if score >= 70
... print("Grade: C")
... else
... if score >= 60
... print("Grade: D")
... else
... print("Grade: F")
... end
... end
... end
... end
... end
> Function calculateGrade defined
>> calculateGrade(85)
Grade: B
>> calculateGrade(92)
Grade: A
```

### Sum of Range

```
>> def sumRange(start, end)
... sum = 0
... for i in range(start, end + 1)
... sum = sum + i
... end
... print("Sum: " + sum)
... end
> Function sumRange defined
>> sumRange(1, 10)
Sum: 55.0
>> sumRange(5, 15)
Sum: 110.0
```

## Best Practices

1. **Use descriptive names**: Function names should describe what they do
2. **Keep functions focused**: Each function should do one thing well
3. **Use parameters**: Make functions reusable with parameters
4. **Document behavior**: Use meaningful variable names inside functions
5. **Test thoroughly**: Test functions with different inputs
