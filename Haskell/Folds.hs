newtype Endo a = Endo {appEndo :: a -> a}

instance Monoid (Endo a) where
  mempty = Endo id

instance Semigroup (Endo a) where
  Endo g <> Endo f = Endo $ g . f

foldComp :: Foldable t => (a1 -> a2 -> a2) -> t a1 -> Endo a2
foldComp f = foldMap (Endo . f)

foldr' :: Foldable t => (a1 -> a -> a) -> a -> t a1 -> a
foldr' f z xs = appEndo (foldComp f xs) z

data Tree a = Leaf | Node a (Tree a) (Tree a) deriving (Show, Eq)

instance Semigroup (Tree a) where
  Leaf <> Leaf = Leaf
  Leaf <> t@(Node _ _ _) = t
  t@(Node _ _ _) <> Leaf = t
  (Node a l r) <> t      = Node a l (r <> t)

instance Monoid (Tree a) where
  mempty = Leaf

instance Functor Tree where
  fmap _ Leaf = Leaf
  fmap f (Node a l r) = Node (f a) (fmap f l) (fmap f r)

instance Foldable Tree where
  foldMap _ Leaf = mempty
  foldMap f (Node a l r) = foldMap f l <> f a <> foldMap f r

instance Traversable Tree where
  traverse _ Leaf = pure Leaf
  traverse f (Node x l r) = Node <$> f x <*> traverse f l <*> traverse f r

t1 :: Tree Int
t1 = Node 6 Leaf (Node 7 Leaf Leaf)

t2 :: Tree Int
t2 = Node 1 (Node 2 Leaf (Node 3 Leaf Leaf)) (Node 4 (Node 5 Leaf Leaf) Leaf)
