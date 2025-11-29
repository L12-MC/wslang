# Strings

## String Literals

Strings can be created using double quotes or single quotes:

```
>> message = "Hello, World!"
> message = "Hello, World!"
>> name = 'Alice'
> name = 'Alice'
```

## String Variables

Assign strings to variables:

```
>> greeting = "Hello"
> greeting = "Hello"
>> print(greeting)
Hello
```

## String Merging (Concatenation)

### Using the `+` operator

Merge two or more strings together:

```
>> first = "Hello"
> first = "Hello"
>> second = "World"
> second = "World"
>> result = first + " " + second
> result = "Hello World"
>> print(result)
Hello World
```

### Merging multiple strings

```
>> part1 = "The"
>> part2 = "quick"
>> part3 = "brown"
>> part4 = "fox"
>> sentence = part1 + " " + part2 + " " + part3 + " " + part4
> sentence = "The quick brown fox"
```

## String Splitting

### Using the `split()` function

Split a string into a list based on a delimiter:

```
>> text = "apple,banana,cherry"
> text = "apple,banana,cherry"
>> fruits = split(text, ",")
> fruits = ["apple", "banana", "cherry"]
>> print(fruits)
["apple", "banana", "cherry"]
```

### Split by space

```
>> sentence = "Hello World from REPL"
> sentence = "Hello World from REPL"
>> words = split(sentence, " ")
> words = ["Hello", "World", "from", "REPL"]
```

### Accessing split elements

After splitting, you can access individual elements:

```
>> text = "one,two,three"
>> parts = split(text, ",")
>> first = parts[0]
> first = "one"
>> print(first)
one
```

## String Length

Get the length of a string using the `length()` function:

```
>> text = "Hello"
> text = "Hello"
>> len = length(text)
> len = 5.0
>> print(len)
5.0
```

## String Indexing

Access individual characters by index (0-based):

```
>> word = "Hello"
> word = "Hello"
>> first = word[0]
> first = "H"
>> last = word[4]
> last = "o"
```

## String Slicing

Extract a substring using slice notation:

```
>> text = "Hello World"
> text = "Hello World"
>> sub = slice(text, 0, 5)
> sub = "Hello"
>> print(sub)
Hello
```

## Common String Operations

### Convert to uppercase

```
>> text = "hello"
>> upper = uppercase(text)
> upper = "HELLO"
```

### Convert to lowercase

```
>> text = "WORLD"
>> lower = lowercase(text)
> lower = "world"
```

### Check if string contains substring

```
>> text = "Hello World"
>> result = contains(text, "World")
> result = true
```

## String Comparison

Compare strings using comparison operators:

```
>> str1 = "apple"
>> str2 = "banana"
>> result = str1 == str2
> result = false
>> same = str1 == "apple"
> same = true
```

## Examples

### Building a full name

```
>> firstName = "John"
>> lastName = "Doe"
>> fullName = firstName + " " + lastName
> fullName = "John Doe"
>> print(fullName)
John Doe
```

### Parsing CSV data

```
>> data = "Alice,30,Engineer"
>> fields = split(data, ",")
>> name = fields[0]
>> age = fields[1]
>> job = fields[2]
>> print(name)
Alice
```

### Creating a greeting

```
>> name = "Alice"
>> greeting = "Hello, " + name + "!"
> greeting = "Hello, Alice!"
>> print(greeting)
Hello, Alice!
```
