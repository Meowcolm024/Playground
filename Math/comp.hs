import Math.Funcs
import Data.Ratio

f :: Integral a => a -> a -> a
f m n = sum [comb m i * comb (n-1) (i-1) | i <- [1 .. n]]

testData :: Integer -> [(Integer, Integer)]
testData m = concat [[(x, y) | y <- [1..x]] | x <- [1..m]]

g1 :: Integral a => (a, a) -> a
g1 (p, q) = comb (p+q) (q+1)

g2 :: Integral a => (a, a) -> a
g2 (p,q) = sum [comb p (k+1) * comb q k | k <- [0..q]]

testEq :: Integer -> Bool
testEq m = let t = testData m in map g1 t == map g2 t

calc :: Integer -> Integer -> Integer
calc x y = sum [(-1)^k * comb y k * (y-k) ^ x | k <- [0..y]]

calc' :: Integer -> Integer -> Integer
calc' x y = sigma 0 y (\k -> (-1)^k * comb y k * (y-k) ^ x)

prob :: Integer -> Integer -> Ratio Integer
prob x y = calc x y % y ^ x

