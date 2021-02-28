primes :: [Integer]
primes = 2 : filter isPrime [3 ..]

isPrime :: Integer -> Bool
isPrime n = foldr (\x acc -> (x*x > n) || (n `rem` x /= 0 && acc)) False primes

factors :: Integer -> [Integer]
factors n = filter (\x -> n `mod` x == 0) (takeWhile (<= n) primes)
