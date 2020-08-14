f :: Int -> [(Int, Int)]
f n = concat [ [ (i, j) | j <- [1 .. (i - 1)] ] | i <- [1 .. n] ]
-- concat . map == flatmap

primes = 2 : filter isPrime [3 ..]
isPrime n =
    foldr (\x acc -> (x ^ 2 > n) || (n `mod` x /= 0 && acc)) True primes

pSum (a, b) = isPrime (a + b)

makePairSum :: (Int, Int) -> (Int, Int, Int)
makePairSum (a, b) = (a, b, a + b)

pSumPairs = map makePairSum . filter pSum . f

pnm :: Eq a => [a] -> [[a]]
pnm [] = [[]]
pnm s  = concatMap (\x -> map (x :) (p (rv x s))) s where rv x = filter (/= x)
