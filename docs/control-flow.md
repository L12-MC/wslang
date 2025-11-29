# Control Flow

Control flow statements allow you to control the execution path of your program.

## If Statements

### Basic If

Execute code only if a condition is true:

```
>> x = 10
>> if x > 5
... print("x is greater than 5")
... end
x is greater than 5
```

### If-Else

Execute different code based on a condition:

```
>> x = 3
>> if x > 5
... print("x is greater than 5")
... else
... print("x is not greater than 5")
... end
x is not greater than 5
```

### Multiple Conditions

```
>> score = 85
>> if score >= 90
... print("Grade: A")
... else
... if score >= 80
... print("Grade: B")
... else
... print("Grade: C")
... end
... end
Grade: B
```

## While Loops

Execute code repeatedly while a condition is true:

```
>> count = 0
>> while count < 5
... print(count)
... count = count + 1
... end
0.0
1.0
2.0
3.0
4.0
```

### Countdown Example

```
>> n = 5
>> while n > 0
... print(n)
... n = n - 1
... end
>> print("Blast off!")
5.0
4.0
3.0
2.0
1.0
Blast off!
```

## For Loops

### Range-based For Loop

Iterate over a range of numbers:

```
>> for i in range(0, 5)
... print(i)
... end
0.0
1.0
2.0
3.0
4.0
```

### Custom Step

```
>> for i in range(0, 10)
... if i % 2 == 0
... print(i)
... end
... end
0.0
2.0
4.0
6.0
8.0
```

### Summing Numbers

```
>> sum = 0
>> for i in range(1, 11)
... sum = sum + i
... end
>> print(sum)
55.0
```

## Comparison Operators in Conditions

### Less Than (<)

```
>> x = 5
>> if x < 10
... print("x is less than 10")
... end
x is less than 10
```

### Greater Than (>)

```
>> x = 15
>> if x > 10
... print("x is greater than 10")
... end
x is greater than 10
```

### Less Than or Equal (<=)

```
>> x = 10
>> if x <= 10
... print("x is less than or equal to 10")
... end
x is less than or equal to 10
```

### Greater Than or Equal (>=)

```
>> x = 10
>> if x >= 10
... print("x is greater than or equal to 10")
... end
x is greater than or equal to 10
```

### Equal To (==)

```
>> x = 10
>> if x == 10
... print("x is exactly 10")
... end
x is exactly 10
```

### Not Equal To (!=)

```
>> x = 5
>> if x != 10
... print("x is not 10")
... end
x is not 10
```

## Nested Loops

Loops inside loops:

```
>> for i in range(1, 4)
... for j in range(1, 4)
... result = i * j
... print(result)
... end
... end
1.0
2.0
3.0
2.0
4.0
6.0
3.0
6.0
9.0
```

## Examples

### Factorial Calculation

```
>> n = 5
>> factorial = 1
>> for i in range(1, n + 1)
... factorial = factorial * i
... end
>> print(factorial)
120.0
```

### Finding Even Numbers

```
>> for i in range(1, 11)
... if i % 2 == 0
... print(i)
... end
... end
2.0
4.0
6.0
8.0
10.0
```

### Sum of Even Numbers

```
>> sum = 0
>> for i in range(1, 11)
... if i % 2 == 0
... sum = sum + i
... end
... end
>> print(sum)
30.0
```

### Countdown with Condition

```
>> count = 10
>> while count >= 0
... if count == 0
... print("Liftoff!")
... else
... print(count)
... end
... count = count - 1
... end
```

### Temperature Checker

```
>> temp = 25
>> if temp < 0
... print("Freezing!")
... else
... if temp < 20
... print("Cold")
... else
... if temp < 30
... print("Comfortable")
... else
... print("Hot!")
... end
... end
... end
Comfortable
```
