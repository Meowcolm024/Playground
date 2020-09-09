merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x : xs) (y : ys)
  | x <= y    = x : merge xs (y : ys)
  | otherwise = y : merge (x : xs) ys

msort :: Ord a => [a] -> [a]
msort []  = []
msort [x] = [x]
msort xs  = merge (msort left) (msort right)
  where
    (left, right) = splitAt (length xs `div` 2) xs

qsort :: Ord a => [a] -> [a]
qsort []       = []
qsort (x : xs) = left ++ [x] ++ right
  where
    left  = filter (<= x) xs
    right = filter (> x) xs