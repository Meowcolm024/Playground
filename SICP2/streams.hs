{-# LANGUAGE TupleSections #-}

import Data.List (inits)

fibgen :: Integer -> Integer -> [Integer]
fibgen a b = a : fibgen b (a + b)

fibs :: [Integer]
fibs = fibgen 0 1

primes :: [Integer]
primes = sieve [2 ..]
  where
    sieve (x : xs) = x : sieve (filter ((/= 0) . (`rem` x)) xs)

pis :: [Double]
pis = map ((* 4) . sum) . tail . inits $ [(-1) ** (n + 1) * (1 / (2 * n -1)) | n <- [1 ..]]

eulerTrans :: [Double] -> [Double]
eulerTrans s =
  let s0 = head s
      s1 = s !! 1
      s2 = s !! 2
   in s2 - ((s2 - s1) ** 2) / (s0 - 2 * s1 + s2) : eulerTrans (tail s)

tableu :: (t -> t) -> t -> [t]
tableu t s = s : tableu t (t s)

accseq :: ([b] -> [b]) -> [b] -> [b]
accseq t s = map head (tableu t s)

interleave :: [a] -> [a] -> [a]
interleave [] s = s
interleave (x : xs) y = x : interleave y xs

pairs :: [Int] -> [Int] -> [(Int, Int)]
pairs (s : ss) (t : ts) = (s, t) : interleave (map (s,) ts) (pairs ss ts)

integral :: Num a => [a] -> a -> a -> [a]
integral input c dt = let i = c : zipWith (+) (map (* dt) input) i in i

solve :: Num a => (a -> a) -> a -> a -> [a]
solve f y0 dt = y
  where
    y = integral dy y0 dt
    dy = map f y

withdraw :: Num t => t -> [t] -> [t]
withdraw b (s:ss) = b : withdraw (b-s) ss
