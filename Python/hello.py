def compose(fs: list):
    return (lambda x: x) if fs == [] else (lambda f1, f2: lambda x: f1(f2(x)))(fs[0], compose(fs[1:]))


def caseOf(val):
    def __caseOf(cases: [tuple], default=None):
        if cases == []:
            return default
        if val == cases[0][0]:
            return cases[0][1]
        return __caseOf(cases[1:], default)
    return __caseOf


for i in range(3):
    print(
        caseOf(i)([
            (1, "hello"),
            (2, compose([lambda x: x*2, lambda x: x + 1])(10))
        ])
    )

def gsum(xs: [int]) -> int:
    return caseOf(xs)(
        [
            ([], 0)
        ],
        (xs[0] + gsum(xs[1:]))
    )

print(
    gsum([])
    )