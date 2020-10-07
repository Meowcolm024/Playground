import Math.Funcs

f :: Integral a => a -> a -> a
f m n = sum [comb m i * comb (n-1) (i-1) | i <- [1 .. n]]
