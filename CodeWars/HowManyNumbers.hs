module HowManyNumbers where

import Data.List (inits, tails)

findAll :: Int -> Int -> (Int, Maybe Int, Maybe Int)
findAll s n = let r = generate s n in if null r then (0, Nothing, Nothing) else (length r, last r, head r)

generate :: Int -> Int -> [Maybe Int]
generate s n
  | (s < n) || (s > 9 * n) = []
  | otherwise = (foldl (\x y -> 10 * x + y) 0 <$>) <$> (filter f $ sep (s - n) (replicate n 1, n))
  where
    f Nothing = False
    f (Just xs) = not $ any (> 9) xs

sep :: Int -> ([Int], Int) -> [Maybe [Int]]
sep _ ([], _) = []
sep 0 (ns, _) = [Just ns]
sep x ([n], _) = if x + n > 9 then [Nothing] else [Just [x + n]]
sep s (n : ns, l) =
  let r = s - l
   in if r >= 0
        then
          let left = zip (init . tail $ inits (n : ns)) [1 .. l -1]
              right = zip (tail . init $ tails (n : ns)) (reverse [1 .. l -1])
              rest = zipWith (\(ps, l1) (qs, l2) -> ((ps ++) <$>) <$> sep (r + l1) (map (+ 1) qs, l2)) left right
           in sep r (map (+ 1) (n : ns), l) ++ foldr (++) [] rest
        else ((n :) <$>) <$> sep s (ns, l -1)

main :: IO ()
main = print $ findAll 105 17
