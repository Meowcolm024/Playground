pascal' :: Int -> [Int] -> Int -> (Int, [Int])
pascal' n xs l | l >= n = (n, xs)
pascal' n xs l = pascal' (n - l) (zipWith (+) (xs ++ [0]) (0 : xs)) (l + 1)

pascal :: Int -> Int
pascal i = let (n, rs) = pascal' i [1] 1 in rs !! (n - 1)

triangle' :: [[Int]] -> [Int] -> Int -> [[Int]]
triangle' acc xs 0 = xs : acc
triangle' acc xs n =
  let t = zipWith (+) (xs ++ [0]) (0 : xs) in triangle' (xs : acc) t (n -1)

triangle :: Int -> [[Int]]
triangle = triangle' [] [1]
