primes :: [Integer]
primes = 2 : filter isPrime [3 ..]

isPrime :: Integer -> Bool
isPrime n = foldr (\x acc -> (x ^ 2 > n) || (n `mod` x /= 0 && acc)) False primes

fib :: [Integer]
fib = 0 : 1 : zipWith (+) fib (tail fib)
