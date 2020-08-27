
-- import Data.List (unwords)

eleSet :: Ord t => t -> [t] -> Bool
eleSet x s | null s    = False
           | x == y    = True
           | x < y     = False
           | otherwise = eleSet x ys
  where
    y  = head s
    ys = tail s


-- >>> eleSet 5 e1
-- True
--
e1 :: [Integer]
e1 = [1..5]

-- >>> eleSet 10 e2
-- False
--
e2 :: [Integer]
e2 = [1..9] ++ [13..18]

