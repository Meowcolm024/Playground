module Snail where

import Data.List ( transpose )

-- elegant way from solution!
snail :: [[Int]] -> [Int]
snail [] = []
snail (x:xs) = x ++ (snail . reverse . transpose) xs

mid :: [c] -> [c]
mid = tail . init

array :: [[Int]]
array = [[1,2,3,1],
         [4,5,6,4],
         [7,8,9,7],
         [7,8,9,7]]

-- my method
act :: [[c]] -> [c]
act [] = []
act [a] = a
act xs = let ys = transpose xs
    in head xs ++ mid (last ys) ++ reverse (last xs) ++ reverse (mid (head ys)) ++ act (map mid (mid xs)) 