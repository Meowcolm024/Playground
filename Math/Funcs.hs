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
isPrime n = foldr (\x acc -> (x * x > n) || (n `rem` x /= 0 && acc)) False primes

-- | fibs
--
-- > fibs == [0, 1, 1, 2, 3, 5, 8, ...
fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- | Factorial
--
-- > fact 0 == 1
-- > fact 5 == 5 * 4 * 3 * 2 * 1 == 120
fact :: Integral a => a -> a
fact 0 = 1
fact n = product [1 .. n]

-- | Big sigma to get sum
--
-- > sigma 1 10 id = 1 + 2 + 3 .. + 10 = 55
-- > sigma 2 4 (\x -> x^2) = 2^2 + 3^2 + 4^2 = 29
sigma :: (Integral a, Floating b) => a -> a -> (b -> b) -> b
sigma i n f = sum [f $ fromIntegral k | k <- [i .. n]]

-- | traceFold to trace iteration
--
-- > traceFold (+1) 0 5 == [1, 2, 3, 4, 5]
traceFold :: Num a => (a -> a) -> a -> Int -> [a]
traceFold f v i
  | i <= 0 = []
  | otherwise = t : traceFold f t (i -1)
  where
    t = f v

-- | traceGcd to show the whole process
--
-- > (a, b, quot, rem)
traceGcd :: Integral t => t -> t -> [(t, t, t, t)]
traceGcd a b =
  if b == 0
    then []
    else (a, b, a `div` b, a `mod` b) : traceGcd b (a `mod` b)

-- | bezout
--
-- > bezout a b = (s, t) -- a => modulo; b => number
-- > gcd a b == s*a + t*b
bezout :: Integral a => a -> a -> (a, a)
bezout =
  ((foldr (\(q, _) (x, y) -> (y - q * x, x)) (1, 0) . init) .)
    . ((map (\(_, _, p, q) -> (p, q)) .) . traceGcd)

-- | inverseZm
--
-- > inverseZm a m = x
-- > a*x `mod` m == 1
inverseZm :: Integral a => a -> a -> a
inverseZm n m = mod (fst (bezout m n)) m
