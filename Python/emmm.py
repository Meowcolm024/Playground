class Identity:
    def __init__(self, val):
        self.value = val

    def runIdentity(self):
        return self.value

    def __eq__(self, x):
        if type(x) == Identity:
            return self.value == x.value
        else:
            return self.value == x

    def __str__(self):
        return f"{self.value}"

def set(val: Identity, x):
    val.value = x

x = Identity(100)

set(x, 233)

print(x)
