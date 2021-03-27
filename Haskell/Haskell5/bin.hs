addBin :: [Int] -> [Int] -> [Int]
addBin p q = reverse $ helper (reverse p) (reverse q) 0
 where
  add x y c = (x + y + c) `divMod` 2
  helper []       []       c = [c]
  helper []       (y : ys) c = let (t, r) = add 0 y c in r : helper [] ys t
  helper (x : xs) []       c = let (t, r) = add x 0 c in r : helper xs [] t
  helper (x : xs) (y : ys) c = let (t, r) = add x y c in r : helper xs ys t
