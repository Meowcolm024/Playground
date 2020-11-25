from functools import reduce
in_num = 1000
in_base = 2
out_base = 36
num = reduce(lambda r, x: r*in_base+x,
             map(lambda c: (lambda x: x-87 if x > 96 else (x-55 if x > 64 else x-48))(ord(c)),
                 in_num),
             0)


def to_out_base(r, n): 
    return (r if len(r) > 0 else [0]) if n == 0 else to_out_base([n % out_base]+r, n//out_base)
