module Fibonacci where

fib :: Integer -> Integer
fib n = let i = abs n in if n >= 0 then fib'' i else (-1) ^ (i -1) * (fib'' i)

fib'' :: Integer -> Integer
fib'' = iter 1 0 0 1
  where
    iter _ b _ _ 0 = b
    iter a b p q n =
      if even n
        then iter a b (p * p + q * q) (q * q + 2 * p * q) (n `quot` 2)
        else iter (b * q + a * q + a * p) (b * p + a * q) p q (n -1)

-- 50 times slower
fib' :: Integer -> Integer
fib' 0 = 0
fib' 1 = 1
fib' n =
  if even n
    then
      let i = n `quot` 2
          j = fib' i
       in (2 * fib' (i -1) + j) * j
    else
      let i = (n + 1) `quot` 2
       in (fib' i) ^ 2 + (fib' (i -1)) ^ 2
