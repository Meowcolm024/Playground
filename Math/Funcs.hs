module Math.Funcs where

-- | Combinations i.e.
--
-- > comb 6 0 == 1
-- > comb 5 2 == 0
comb :: Integral a => a -> a -> a
comb _ 0 = 1
comb m n = go (n -1) m `div` fact n
  where
    go 0 x = x
    go y x = x * go (y -1) (x -1)

-- | Lazy list of prime numbers
--
-- > primes == [2, 3, 5, 7, 11, ...
primes :: [Int]
primes = 2 : filter isPrime [3 ..]

-- | Test if is a prime
--
-- > isPrime 29 == True
-- > isPrime 8 == False
isPrime :: Int -> Bool
isPrime n = foldr (\x acc -> (x*x > n) || (n `rem` x /= 0 && acc)) False primes

-- | fibs
-- 
-- > fibs == [0, 1, 1, 2, 3, 5, 8, ...
fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fib (tail fib)

-- | Factorial
--
-- > fact 0 == 1
-- > fact 5 == 5 * 4 * 3 * 2 * 1 == 120
fact :: Integral a => a -> a
fact 0 = 1
fact n = product [1..n]
