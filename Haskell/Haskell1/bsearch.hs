import           Data.List

minFree :: [Int] -> Int
minFree xs = bsearch xs 0 (length xs - 1)

bsearch :: [Int] -> Int -> Int -> Int
bsearch xs l u | null xs = l
               | length as == m - l + 1 = bsearch bs (m + 1) u
               | otherwise = bsearch as l m
               where
                   m = (l + u) `div` 2
                   (as, bs) = partition (<= m) xs

main :: IO ()
main = print $ minFree [0,1,2,3,5,6]
