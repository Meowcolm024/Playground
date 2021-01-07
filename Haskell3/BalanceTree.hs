module BalanceTree where

sat :: (a -> Bool) -> (a -> a) -> (a -> a)
sat p f = \x -> if p x then f x else x

infixl 1 &

(&) :: a -> (a -> c) -> c
(&) = flip ($)

data Color = Red | Black deriving (Show)

data Tree a
  = Leaf
  | Node
      { key :: Int,
        val :: a,
        left :: Tree a,
        right :: Tree a,
        height :: Int,
        color :: Color
      }

instance Show a => Show (Tree a) where
    show Leaf = "X"
    show (Node k _ l r _ c) =
        show l ++ " | (" ++ show k ++ "-" ++ show c ++ ") | " ++ show r

setColor :: Tree a -> Color -> Tree a
setColor Leaf               _ = Leaf
setColor (Node k v l r s _) c = Node k v l r s c

isRed :: Tree a -> Bool
isRed (Node _ _ _ _ _ Red) = True
isRed _                    = False

setLeft :: Tree a -> Tree a -> Tree a
setLeft Leaf               _ = Leaf
setLeft (Node k v _ r s c) l = Node k v l r s c

setRight :: Tree a -> Tree a -> Tree a
setRight Leaf               _ = Leaf
setRight (Node k v l _ s c) r = Node k v l r s c

size :: Tree a -> Int
size Leaf     = 0
size n@Node{} = height n

left' :: Tree a -> Tree a
left' Leaf     = Leaf
left' n@Node{} = left n

right' :: Tree a -> Tree a
right' Leaf     = Leaf
right' n@Node{} = right n

rotateLeft :: Tree a -> Tree a
rotateLeft Leaf                    = Leaf
rotateLeft n@(Node _ _ _ Leaf _ _) = n
rotateLeft (Node k v l (Node xk xv xl xr _ _) n c) =
    let h = Node k v l xl (size l + size xl + 1) Red in Node xk xv h xr n c

rotateRight :: Tree a -> Tree a
rotateRight Leaf                    = Leaf
rotateRight n@(Node _ _ Leaf _ _ _) = n
rotateRight (Node k v (Node xk xv xl xr _ _) r n c) =
    let h = Node k v xr r (size xr + size r + 1) Red in Node xk xv xl h n c

flipColor :: Tree a -> Tree a
flipColor (Node k v l@Node{} r@Node{} n _) =
    Node k v (setColor l Black) (setColor r Black) n Red
flipColor n = n

put :: Int -> a -> Tree a -> Tree a
put k v Leaf = Node k v Leaf Leaf 1 Red
put k v h@Node{} =
    make h & sat sa rotateLeft & sat sb rotateRight & sat sc flipColor & resize
  where
    make Leaf = Leaf
    make (Node nk nv l r n c) | k < nk    = Node nk nv (put k v l) r n c
                              | k > nk    = Node nk nv l (put k v r) n c
                              | otherwise = Node k v l r n c
    sa x = isRed (right' x) && (not . isRed . left') x
    sb x = isRed (left' x) && (isRed . left' . left') x
    sc x = isRed (left' x) && isRed (right' x)
    resize Leaf                 = Leaf
    resize (Node rk rv l r _ c) = Node rk rv l r (size l + size r + 1) c

delete :: Int -> Tree a -> Tree a
delete _ Leaf = Leaf
delete _ _    = undefined

putRoot :: Int -> a -> Tree a -> Tree a
putRoot k v t = flip setColor Black $ put k v t

sample :: Tree Char
sample =
    Leaf
        & putRoot 1  'A'
        & putRoot 3  'C'
        & putRoot 5  'E'
        & putRoot 8  'H'
        & putRoot 12 'L'
        & putRoot 13 'M'
        & putRoot 15 'P'
        & putRoot 17 'R'
