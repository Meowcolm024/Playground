
fix :: (Float -> Float) -> Float -> Float
fix f = test
  where
    test x = let next = f x in if close next x then next else test next
    close a b = abs (a - b) < 0.00001

sq :: Float -> Float
sq x = fix (\y -> (y + x / y) / 2) 1

avgDamp :: Fractional a => (a -> a) -> (a -> a)
avgDamp f x = (x + f x) / 2
