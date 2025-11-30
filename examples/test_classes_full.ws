class Rectangle
width = 0
height = 0
def init(w, h)
this.width = w
this.height = h
end
def area()
result = this.width * this.height
print(result)
end
def perimeter()
result = 2 * (this.width + this.height)
print(result)
end
end

rect = new Rectangle(5, 10)
rect.area()
rect.perimeter()

class Counter
count = 0
def increment()
this.count = this.count + 1
end
def getCount()
print(this.count)
end
end

counter = new Counter()
counter.increment()
counter.increment()
counter.getCount()
