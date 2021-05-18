data Tree a = Leaf | Node (Tree a) a (Tree a) deriving (Show, Eq)
data Zipper a = TurnLeft (Tree a) a (Zipper a) | TurnRight (Zipper a) a (Tree a) | Top (Tree a) deriving (Show, Eq)
data Direction = L | R deriving (Show, Eq)

goDown :: Direction -> Zipper a -> Maybe (Zipper a)
goDown L (Top (Node left v right)) = Just $ TurnLeft left v (Top right)
goDown L (TurnLeft (Node left v right) x z) =
    Just $ TurnLeft left v (TurnLeft right x z)
goDown L (TurnRight z x (Node left v right)) =
    Just $ TurnLeft left v (TurnRight z x right)
goDown R (Top (Node left v right)) = Just $ TurnRight (Top left) v right
goDown R (TurnLeft (Node left v right) x z) =
    Just $ TurnRight (TurnLeft left x z) v right
goDown R (TurnRight z x (Node left v right)) =
    Just $ TurnRight (TurnRight z x left) v right
goDown _ _ = Nothing

goUp :: Zipper a -> Zipper a
goUp (Top a) = Top a
goUp (TurnLeft left v (Top right)) = Top $ Node left v right
goUp (TurnLeft left v (TurnLeft right x z)) = TurnLeft (Node left v right) x z
goUp (TurnLeft left v (TurnRight z x right)) =
    TurnRight z x (Node left v right)
goUp (TurnRight (Top left         ) v right) = Top $ Node left v right
goUp (TurnRight (TurnLeft left x z) v right) = TurnLeft (Node left v right) x z
goUp (TurnRight (TurnRight z x left) v right) =
    TurnRight z x (Node left v right)

depths :: Tree a -> Int -> Int
depths Leaf                _   = 0
depths (Node Leaf _ Leaf ) acc = acc
depths (Node left _ right) acc = depths left (acc + 1) + depths right (acc + 1)

-- >>> depths sample 0
-- it :: ()
-- (0.00 secs, 94,520 bytes)
-- 9
-- it :: Int
-- (0.01 secs, 71,328 bytes)
--
sample :: Tree Integer
sample = Node
    (Node (Node (Node Leaf 6 Leaf) 3 (Node Leaf 7 Leaf)) 2 (Node Leaf 4 Leaf))
    1
    (Node Leaf 5 Leaf)

-- >>> pathCount sample
-- it :: ()
-- (0.00 secs, 94,520 bytes)
-- 4
-- it :: Int
-- (0.00 secs, 69,464 bytes)
--
