version()
print("=== Testing Classes ===")

class BankAccount
owner = ""
balance = 0
def init(owner_name, initial_balance)
this.owner = owner_name
this.balance = initial_balance
end
def deposit(amount)
this.balance = this.balance + amount
print(this.balance)
end
def withdraw(amount)
if amount <= this.balance
this.balance = this.balance - amount
print(this.balance)
else
print("Insufficient funds")
end
end
def getBalance()
print(this.balance)
end
end

account = new BankAccount("Alice", 1000)
print("Initial balance:")
account.getBalance()
print("After deposit of 500:")
account.deposit(500)
print("After withdrawal of 200:")
account.withdraw(200)

print("=== All tests passed! ===")
