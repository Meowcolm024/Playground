
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

data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show, Eq)

eleTree :: Ord a => a -> Tree a -> Bool
eleTree _ Empty = False
eleTree x (Node y left right) 
  | x == y = True
  | x < y = eleTree x left
  | x > y = eleTree x right

-- >>> eleTree 3 $ Node 5 (Node 3 Empty Empty) (Node 5 Empty Empty)-- attempting to use module ‘fake_uid:Main’ (/Users/yatchunglaw/Playground/SICP/sets2.hs) which is not loaded
-- True
--
