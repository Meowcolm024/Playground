primes :: [Int]
primes = 2 : filter isPrime [3 ..]

isPrime :: Int -> Bool
isPrime n = foldr (\x acc -> (x*x > n) || (n `rem` x /= 0 && acc)) False primes

main :: IO ()
main = print $ length $ takeWhile (< 10^(7::Int)) primes

-- ghc Funcs.hs -o f.out -O2 && time ./f.out