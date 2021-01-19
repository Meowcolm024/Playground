data TList a = TList {forward :: [a], backward :: [a], len :: Int} deriving (Show, Eq)

instance Functor TList where
  fmap f (TList xs ys l) = TList (fmap f xs) (fmap f ys) l

instance Foldable TList where
  length = len
  foldr f b (TList x _ _) = foldr f b x

cons :: a -> TList a -> TList a
cons x (TList xs ys l) = TList (x : xs) (ys ++ [x]) (l + 1)

empty :: TList a
empty = TList [] [] 0

item :: TList a -> Int -> a
item y x | x < 0 || len y == 0 = undefined
item (TList f b l) x = if x < l `div` 2 then f !! x else b !! (l -1 - x)

fromList :: [a] -> TList a
fromList xs = TList xs (reverse xs) (length xs)

data WList a = Nil | Node (WList a) a (WList a) deriving (Show, Eq)

connect :: WList a -> WList a -> WList a
connect Nil x = x
connect x Nil = x
connect l@(Node f1 v1 _) (Node _ v2 b2) =
  let t = Node l v2 b2
   in Node f1 v1 t

consW :: a -> WList a -> WList a
consW x Nil = Node Nil x Nil
consW x n@Node{} = connect (Node Nil x Nil) n
