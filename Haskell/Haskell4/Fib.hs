fib :: Integer -> (Integer, Integer)
fib 1 = (0, 1)
fib n = if even n then (prev, curr) else (curr, next)
  where
    (hprv, hcur) = fib (n `quot` 2)
    prev = hprv ^ 2 + hcur ^ 2
    curr = hcur * (2 * hprv + hcur)
    next = prev + curr
