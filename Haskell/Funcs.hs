
primes :: [Integer]
primes = 2 : filter (`isp` primes) [3..]

isp :: Integer -> [Integer] -> Bool
isp n = foldr (\x acc -> (x ^ 2 > n) || (n `mod` x /= 0 && acc)) False

fib :: [Integer]
fib = 0 : 1 : zipWith (+) fib (tail fib)
