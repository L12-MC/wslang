# Examples

This document contains comprehensive examples demonstrating various features of the REPL language.

## Example 1: Simple Calculator Session

```
repl v0.2
>> x = 10
> x = 10.0
>> y = 20
> y = 20.0
>> sum = x + y
> sum = 30.0
>> product = x * y
> product = 200.0
>> print(sum)
30.0
>> print(product)
200.0
```

## Example 2: Temperature Converter

```
>> def celsiusToFahrenheit(c)
... f = (c * 9 / 5) + 32
... print("Celsius: " + c)
... print("Fahrenheit: " + f)
... end
> Function celsiusToFahrenheit defined
>> celsiusToFahrenheit(0)
Celsius: 0.0
Fahrenheit: 32.0
>> celsiusToFahrenheit(25)
Celsius: 25.0
Fahrenheit: 77.0
>> celsiusToFahrenheit(100)
Celsius: 100.0
Fahrenheit: 212.0
```

## Example 3: String Manipulation

```
>> firstName = "John"
> firstName = "John"
>> lastName = "Doe"
> lastName = "Doe"
>> fullName = firstName + " " + lastName
> fullName = "John Doe"
>> print(fullName)
John Doe
>> data = "apple,banana,cherry,date"
> data = "apple,banana,cherry,date"
>> fruits = split(data, ",")
> fruits = ["apple", "banana", "cherry", "date"]
>> print(fruits[0])
apple
>> print(fruits[2])
cherry
```

## Example 4: List Operations

```
>> numbers = [5, 2, 8, 1, 9, 3]
> numbers = [5, 2, 8, 1, 9, 3]
>> sorted = sort(numbers)
> sorted = [1, 2, 3, 5, 8, 9]
>> append(numbers, 10)
> numbers = [5, 2, 8, 1, 9, 3, 10]
>> print(length(numbers))
7.0
>> for i in range(0, length(numbers))
... print(numbers[i])
... end
5.0
2.0
8.0
1.0
9.0
3.0
10.0
```

## Example 5: Factorial Calculator

```
>> def factorial(n)
... if n <= 1
... print(1)
... else
... result = 1
... for i in range(2, n + 1)
... result = result * i
... end
... print(result)
... end
... end
> Function factorial defined
>> factorial(5)
120.0
>> factorial(6)
720.0
>> factorial(10)
3628800.0
```

## Example 6: Find Maximum in List

```
>> numbers = [23, 67, 12, 89, 45, 34, 90, 56]
> numbers = [23, 67, 12, 89, 45, 34, 90, 56]
>> max = numbers[0]
> max = 23.0
>> for i in range(1, length(numbers))
... if numbers[i] > max
... max = numbers[i]
... end
... end
>> print("Maximum value: " + max)
Maximum value: 90.0
```

## Example 7: Filtering Even Numbers

```
>> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>> evens = []
> evens = []
>> for i in range(0, length(numbers))
... if numbers[i] % 2 == 0
... append(evens, numbers[i])
... end
... end
>> print("Even numbers:")
Even numbers:
>> print(evens)
[2.0, 4.0, 6.0, 8.0, 10.0]
```

## Example 8: Bank Account Class

```
>> class BankAccount
... def init(owner, balance)
... this.owner = owner
... this.balance = balance
... end
... def deposit(amount)
... this.balance = this.balance + amount
... print("Deposited: " + amount)
... print("New balance: " + this.balance)
... end
... def withdraw(amount)
... if amount <= this.balance
... this.balance = this.balance - amount
... print("Withdrew: " + amount)
... print("New balance: " + this.balance)
... else
... print("Insufficient funds!")
... end
... end
... end
> Class BankAccount defined
>> myAccount = new BankAccount("Alice", 1000)
> myAccount = BankAccount instance
>> myAccount.deposit(500)
Deposited: 500.0
New balance: 1500.0
>> myAccount.withdraw(300)
Withdrew: 300.0
New balance: 1200.0
>> myAccount.withdraw(2000)
Insufficient funds!
```

## Example 9: Rectangle Class

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
... def scale(factor)
... this.width = this.width * factor
... this.height = this.height * factor
... print("Scaled by " + factor)
... end
... end
> Class Rectangle defined
>> rect = new Rectangle(5, 10)
>> rect.area()
Area: 50.0
>> rect.perimeter()
Perimeter: 30.0
>> rect.scale(2)
Scaled by 2.0
>> rect.area()
Area: 200.0
```

## Example 10: Prime Number Checker

```
>> def isPrime(n)
... if n <= 1
... print(false)
... else
... isPrimeFlag = true
... for i in range(2, n)
... if n % i == 0
... isPrimeFlag = false
... end
... end
... print(isPrimeFlag)
... end
... end
> Function isPrime defined
>> isPrime(7)
true
>> isPrime(10)
false
>> isPrime(17)
true
>> isPrime(20)
false
```

## Example 11: Fibonacci Sequence

```
>> def fibonacci(n)
... a = 0
... b = 1
... for i in range(0, n)
... print(a)
... temp = a
... a = b
... b = temp + b
... end
... end
> Function fibonacci defined
>> fibonacci(10)
0.0
1.0
1.0
2.0
3.0
5.0
8.0
13.0
21.0
34.0
```

## Example 12: Shopping List Manager

```
>> shoppingList = []
> shoppingList = []
>> def addItem(item)
... append(shoppingList, item)
... print("Added: " + item)
... end
> Function addItem defined
>> def showList()
... print("Shopping List:")
... for i in range(0, length(shoppingList))
... print(shoppingList[i])
... end
... end
> Function showList defined
>> addItem("milk")
Added: milk
>> addItem("bread")
Added: bread
>> addItem("eggs")
Added: eggs
>> showList()
Shopping List:
milk
bread
eggs
```

## Example 13: Grade Calculator

```
>> def calculateGrade(score)
... if score >= 90
... grade = "A"
... else
... if score >= 80
... grade = "B"
... else
... if score >= 70
... grade = "C"
... else
... if score >= 60
... grade = "D"
... else
... grade = "F"
... end
... end
... end
... end
... print("Score: " + score + " = Grade: " + grade)
... end
> Function calculateGrade defined
>> calculateGrade(95)
Score: 95.0 = Grade: A
>> calculateGrade(82)
Score: 82.0 = Grade: B
>> calculateGrade(55)
Score: 55.0 = Grade: F
```

## Example 14: Word Counter

```
>> def countWords(text)
... words = split(text, " ")
... count = length(words)
... print("Word count: " + count)
... end
> Function countWords defined
>> sentence = "The quick brown fox jumps over the lazy dog"
> sentence = "The quick brown fox jumps over the lazy dog"
>> countWords(sentence)
Word count: 9.0
```

## Example 15: Sum and Average Calculator

```
>> def sumAndAverage(numbers)
... sum = 0
... for i in range(0, length(numbers))
... sum = sum + numbers[i]
... end
... avg = sum / length(numbers)
... print("Sum: " + sum)
... print("Average: " + avg)
... end
> Function sumAndAverage defined
>> scores = [85, 90, 78, 92, 88]
> scores = [85, 90, 78, 92, 88]
>> sumAndAverage(scores)
Sum: 433.0
Average: 86.6
```

These examples demonstrate the power and flexibility of the REPL language. Try them out and modify them to explore more features!
