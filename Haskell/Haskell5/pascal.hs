pascal' :: Int -> [Int] -> Int -> (Int, [Int])
pascal' n xs l | l >= n = (n, xs)
pascal' n xs l = pascal' (n - l) (zipWith (+) (xs ++ [0]) (0 : xs)) (l + 1)

pascal :: Int -> Int
pascal i = let (n, rs) = pascal' i [1] 1 in rs !! (n - 1)
