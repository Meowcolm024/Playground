module Permutations where

nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (x : xs) = x : nub (filter (/= x) xs)

permutate :: [a] -> [[a]]
permutate [] = [[]]
permutate ys = concatMap (\(p : ps) -> map (p :) (permutate ps)) (rotate ys)

rotate :: [a] -> [[a]]
rotate rs = rt rs (length rs)
  where
    rt [] _ = []
    rt _ 0 = []
    rt (x : xs) l = (x : xs) : rt (xs ++ [x]) (l -1)

permutations :: String -> [String]
permutations = nub . permutate
