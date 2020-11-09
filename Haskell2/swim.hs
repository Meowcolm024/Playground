{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveFunctor #-}

data Tree a = Leaf | Node (Tree a) a (Tree a) deriving (Show, Functor, Foldable)

-- | this swim is actually sink :(
swim :: (Ord a) => Tree a -> Tree a
swim Leaf = Leaf
swim n@(Node Leaf _ Leaf) = n
swim (Node Leaf v n@(Node rl vr rr)) = if v >= vr then Node Leaf v (swim n) else Node Leaf vr (swim (Node rl v rr))
swim (Node n@(Node ll vl lr) v Leaf) = if v >= vl then Node (swim n) v Leaf else Node (swim (Node ll v lr)) vl Leaf
swim (Node n@(Node ll vl lr) v m@(Node rl vr rr))
  | v >= vl && v >= vr = Node (swim n) v (swim m)
  | vr > vl = Node (swim n) vr (swim (Node rl v rr))
  | otherwise = Node (swim (Node ll v lr)) vl (swim m)

-- insert, still a poor version
insert :: (Ord a) => a -> Tree a -> Tree a
insert x Leaf = Node Leaf x Leaf
insert x n@(Node Leaf v Leaf) = if x <= v then Node (Node Leaf x Leaf) v Leaf else Node n x Leaf
insert x (Node l@(Node _ _ _) v Leaf) = if x <= v then Node l v (Node Leaf x Leaf) else Node l x (Node Leaf v Leaf)
insert x (Node Leaf v r@(Node _ _ _)) = if x <= v then Node (Node Leaf x Leaf) v r else Node (Node Leaf v Leaf) x r
insert x (Node n@(Node _ vl _) v m@(Node _ _ _)) =
  if x <= v
    then
      if x <= vl
        then Node (insert x n) v m
        else Node n v (insert x m)
    else Node n x (Node Leaf v m)

rmMax :: (Ord a) => Tree a -> [a]
rmMax Leaf = []
rmMax (Node Leaf x Leaf) = pure x
rmMax (Node Leaf x r@(Node _ _ _)) = x : rmMax r
rmMax (Node l@(Node _ _ _) x Leaf) = x : rmMax l
rmMax (Node l@(Node _ vl _) x r@(Node _ vr _)) =
  if vl > vr
    then x : rmMax l ++ rmMax r
    else x : rmMax r ++ rmMax l

fromFold :: (Foldable t, Ord a) => t a -> Tree a
fromFold = foldr insert Leaf

t1 :: Tree Int
t1 =
  Node
    ( Node
        (Node Leaf 3 Leaf)
        2
        (Node Leaf 6 (Node Leaf 1 Leaf))
    )
    9
    ( Node
        (Node (Node Leaf 8 Leaf) 7 (Node Leaf 5 Leaf))
        10
        (Node Leaf 5 Leaf)
    )

t2 :: Tree Int
t2 =
  Node
    ( Node
        (Node Leaf 8 Leaf)
        9
        (Node Leaf 4 (Node Leaf 6 Leaf))
    )
    1
    ( Node
        (Node (Node Leaf 3 Leaf) 7 (Node Leaf 5 Leaf))
        2
        (Node Leaf 5 Leaf)
    )

l1 :: [Int]
l1 = [1,4,3,6,8,4,12,4,43,12,89,5,0]
