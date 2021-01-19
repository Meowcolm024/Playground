{- import Data.List.Ordered (minus)

primes :: [Int]
primes = euler [2..]

euler :: [Int] -> [Int]
euler (p:xs) = p : euler (xs `minus` map (*p) (p:xs)) -}

import qualified Data.Set as PQ

primes :: [Int]
primes = 2:sieve [3,5..]
  where
    sieve (x:xs) = x : sieve' xs (insertprime x xs PQ.empty)

    sieve' (x:xs) table
        | nextComposite == x = sieve' xs (adjust x table)
        | otherwise          = x : sieve' xs (insertprime x xs table)
      where 
        (nextComposite,_) = PQ.findMin table

    adjust x table
        | n == x    = adjust x (PQ.insert (n', ns) newPQ)
        | otherwise = table
      where
        Just ((n, n':ns), newPQ) = PQ.minView table

    insertprime p xs = PQ.insert (p*p, map (*p) xs)

main :: IO ()
main = print $ length $ takeWhile (< 10000000) primes
