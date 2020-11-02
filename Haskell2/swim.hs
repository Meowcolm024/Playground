{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveFunctor #-}

data Tree a = Leaf | Node (Tree a) a (Tree a) deriving (Show, Functor, Foldable)

swim :: (Ord a) => Tree a -> Tree a
swim Leaf = Leaf
swim n@(Node Leaf _ Leaf) = n
swim (Node Leaf v n@(Node rl vr rr)) = if v >= vr then Node Leaf v (swim n) else Node Leaf vr (swim (Node rl v rr))
swim (Node n@(Node ll vl lr) v Leaf) = if v >= vl then Node (swim n) v Leaf else Node (swim (Node ll v lr)) vl Leaf
swim (Node n@(Node ll vl lr) v m@(Node rl vr rr))
  | v >= vl && v >= vr = Node (swim n) v (swim m)
  | v >= vl && v < vr = Node (swim n) vr (swim (Node rl v rr))
  | v < vl && v >= vr = Node (swim (Node ll v lr)) vl (swim m)
  | otherwise = if vl > vr then Node (swim (Node ll v lr)) vl (swim m) else Node (swim n) vr (swim (Node rl v rr))

t1 :: Tree Int
t1 =
  Node
    ( Node
        (Node Leaf 3 Leaf)
        2
        ( Node
            Leaf
            6
            (Node Leaf 1 Leaf)
        )
    )
    9
    ( Node
        ( Node
            (Node Leaf 8 Leaf)
            7
            (Node Leaf 5 Leaf)
        )
        10
        (Node Leaf 5 Leaf)
    )
