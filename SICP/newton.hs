fix :: (Float -> Float) -> Float -> Float
fix f = test
  where
    test x = let next = f x in if close next x then next else test next
    close a b = abs (a - b) < 0.00001

df :: (Float -> Float) -> Float -> Float
df f x = let dx = 0.00001 in (f (x+dx) - f x) / dx

iterNt :: (Float -> Float) -> Float -> Float
iterNt f x = x - f x / df f x

-- | finding fix point actually
loop :: Int -> (a -> a) -> a -> a
loop 0 f x = f x
loop n f x = loop (n-1) f (f x)

zero = iterNt log

 
