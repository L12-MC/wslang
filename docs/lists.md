# Lists

Lists are ordered collections that can hold multiple values of any type.

## Creating Lists

### List Literals

Create a list using square brackets:

```
>> numbers = [1, 2, 3, 4, 5]
> numbers = [1, 2, 3, 4, 5]
>> names = ["Alice", "Bob", "Charlie"]
> names = ["Alice", "Bob", "Charlie"]
>> mixed = [1, "hello", true, 3.14]
> mixed = [1, "hello", true, 3.14]
```

### Empty Lists

```
>> emptyList = []
> emptyList = []
```

## Accessing List Elements

### By Index (0-based)

```
>> fruits = ["apple", "banana", "cherry"]
> fruits = ["apple", "banana", "cherry"]
>> first = fruits[0]
> first = "apple"
>> second = fruits[1]
> second = "banana"
>> print(first)
apple
```

### Negative Indexing

Access elements from the end of the list:

```
>> numbers = [10, 20, 30, 40, 50]
>> last = numbers[-1]
> last = 50.0
>> secondLast = numbers[-2]
> secondLast = 40.0
```

## Modifying Lists

### Update Element

```
>> numbers = [1, 2, 3]
>> numbers[1] = 99
> numbers = [1, 99, 3]
```

### Append Element

Add an element to the end of the list:

```
>> numbers = [1, 2, 3]
>> append(numbers, 4)
> numbers = [1, 2, 3, 4]
```

### Insert Element

Insert at a specific position:

```
>> numbers = [1, 2, 4]
>> insert(numbers, 2, 3)
> numbers = [1, 2, 3, 4]
```

### Remove Element

Remove by value:

```
>> numbers = [1, 2, 3, 2, 4]
>> remove(numbers, 2)
> numbers = [1, 3, 2, 4]
```

Remove by index:

```
>> numbers = [1, 2, 3, 4]
>> removeAt(numbers, 1)
> numbers = [1, 3, 4]
```

## List Operations

### Length

Get the number of elements:

```
>> numbers = [1, 2, 3, 4, 5]
>> len = length(numbers)
> len = 5.0
>> print(len)
5.0
```

### Concatenation

Merge two lists:

```
>> list1 = [1, 2, 3]
>> list2 = [4, 5, 6]
>> combined = list1 + list2
> combined = [1, 2, 3, 4, 5, 6]
```

### Slicing

Extract a portion of the list:

```
>> numbers = [0, 1, 2, 3, 4, 5]
>> sub = slice(numbers, 1, 4)
> sub = [1, 2, 3]
>> print(sub)
[1, 2, 3]
```

### Reverse

Reverse the order of elements:

```
>> numbers = [1, 2, 3, 4, 5]
>> reversed = reverse(numbers)
> reversed = [5, 4, 3, 2, 1]
```

### Sort

Sort the list in ascending order:

```
>> numbers = [3, 1, 4, 1, 5, 9, 2]
>> sorted = sort(numbers)
> sorted = [1, 1, 2, 3, 4, 5, 9]
```

## List Methods

### Contains

Check if an element exists:

```
>> numbers = [1, 2, 3, 4, 5]
>> result = contains(numbers, 3)
> result = true
>> notFound = contains(numbers, 10)
> notFound = false
```

### Index Of

Find the index of an element:

```
>> fruits = ["apple", "banana", "cherry"]
>> idx = indexOf(fruits, "banana")
> idx = 1.0
```

### Count

Count occurrences of a value:

```
>> numbers = [1, 2, 2, 3, 2, 4]
>> count = count(numbers, 2)
> count = 3.0
```

### Clear

Remove all elements:

```
>> numbers = [1, 2, 3, 4, 5]
>> clear(numbers)
> numbers = []
```

## Iterating Over Lists

### Using for loops

```
>> numbers = [1, 2, 3, 4, 5]
>> for i in range(0, length(numbers))
... print(numbers[i])
... end
1.0
2.0
3.0
4.0
5.0
```

### Processing each element

```
>> numbers = [1, 2, 3, 4, 5]
>> sum = 0
>> for i in range(0, length(numbers))
... sum = sum + numbers[i]
... end
>> print(sum)
15.0
```

## List Conversion

### String to List

Split a string into a list:

```
>> text = "apple,banana,cherry"
>> fruits = split(text, ",")
> fruits = ["apple", "banana", "cherry"]
```

### List to String

Join list elements into a string:

```
>> fruits = ["apple", "banana", "cherry"]
>> text = join(fruits, ", ")
> text = "apple, banana, cherry"
>> print(text)
apple, banana, cherry
```

## Examples

### Finding maximum value

```
>> numbers = [3, 7, 2, 9, 1, 5]
>> max = numbers[0]
>> for i in range(1, length(numbers))
... if numbers[i] > max
... max = numbers[i]
... end
... end
>> print(max)
9.0
```

### Filtering even numbers

```
>> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>> evens = []
>> for i in range(0, length(numbers))
... if numbers[i] % 2 == 0
... append(evens, numbers[i])
... end
... end
>> print(evens)
[2.0, 4.0, 6.0, 8.0, 10.0]
```

### Creating a shopping list

```
>> shoppingList = []
>> append(shoppingList, "milk")
>> append(shoppingList, "bread")
>> append(shoppingList, "eggs")
>> print(shoppingList)
["milk", "bread", "eggs"]
>> print("Items to buy:")
Items to buy:
>> for i in range(0, length(shoppingList))
... print(shoppingList[i])
... end
milk
bread
eggs
```
