class Person
name = ""
age = 0
def init(n, a)
this.name = n
this.age = a
end
def greet()
print(this.name)
end
end

person1 = new Person("Alice", 30)
person1.greet()
print(person1.name)
print(person1.age)
