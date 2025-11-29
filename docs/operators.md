# Operators and Expressions

## Arithmetic Operators

### Addition (+)
```
>> 5 + 3
> 8.0
>> x = 10
>> y = x + 5
> y = 15.0
```

### Subtraction (-)
```
>> 10 - 3
> 7.0
>> x = 20
>> y = x - 8
> y = 12.0
```

### Multiplication (*)
```
>> 4 * 5
> 20.0
>> x = 3
>> y = x * 7
> y = 21.0
```

### Division (/)
```
>> 20 / 4
> 5.0
>> x = 15
>> y = x / 3
> y = 5.0
```

**Note:** Division by zero returns an error message.

### Modulo (%)
```
>> 10 % 3
> 1.0
>> 17 % 5
> 2.0
```

## Comparison Operators

### Less Than (<)
```
>> 5 < 10
> true
```

### Greater Than (>)
```
>> 15 > 10
> true
```

### Less Than or Equal (<=)
```
>> 5 <= 5
> true
>> 3 <= 10
> true
```

### Greater Than or Equal (>=)
```
>> 10 >= 5
> true
>> 7 >= 7
> true
```

### Equal To (==)
```
>> 5 == 5
> true
>> 5 == 3
> false
```

### Not Equal To (!=)
```
>> 5 != 3
> true
>> 5 != 5
> false
```

## Expression Evaluation

### Order of Operations

The language follows standard mathematical order of operations:
1. Parentheses `()`
2. Multiplication `*`, Division `/`, Modulo `%`
3. Addition `+`, Subtraction `-`

```
>> 2 + 3 * 4
> 14.0
>> (2 + 3) * 4
> 20.0
>> 10 + 20 / 2
> 20.0
```

### Complex Expressions

Combine multiple operators in one expression:

```
>> (5 + 3) * (10 - 2)
> 64.0
>> 100 / (5 + 5)
> 10.0
>> (10 + 5) * 2 - 8 / 4
> 28.0
```

### Using Variables in Expressions

```
>> x = 10
> x = 10.0
>> y = 5
> y = 5.0
>> z = (x + y) * 2
> z = 30.0
>> result = (x * y) + (z / 3)
> result = 60.0
```
