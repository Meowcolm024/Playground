module Going where

import Data.Ratio

going :: Integer -> Double
going n = pt . fromRational $ (efs n $ tail facts) % (fact n facts)

factorial :: [Integer]
factorial = 2 : 6 : zipWith (*) (iterate (+1) 4) (tail factorial)

facts :: [Integer]
facts = 1:1:factorial

fact 0 (x:_) = x
fact i (_:xs) = fact (i-1) xs

efs 0 _ = 0
efs i (x:xs) = x + efs (i-1) xs

pt :: Double -> Double
pt x = 
  let (n, d) = span (/='.') $ show x
  in read $ n ++ (take 7) d
