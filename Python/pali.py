import random
import string


def palindromes(s: str):
    acc = []
    for i in range(len(s)):
        for j in range(i+2, len(s)):
            tmp = s[i:j]
            if tmp == tmp[::-1]:
                acc += [tmp]
    acc.sort(key=len)
    acc.reverse()
    return [] if acc == [] else list(filter(lambda x: len(x) == len(acc[0]), acc))


test = ''.join(random.choice(string.ascii_uppercase + string.digits)
               for _ in range(1000))
print(palindromes(test))
