module BalanceTree where

import           Data.Function                  ( (&) )

sat :: (a -> Bool) -> (a -> a) -> (a -> a)
sat p f = \x -> if p x then f x else x

type Key = Int

data Color = Red | Black deriving (Show)

data Tree a
  = Leaf
  | Node
      { _key :: Key,
        _val :: a,
        _left :: Tree a,
        _right :: Tree a,
        _size :: Int,
        _color :: Color
      }

instance Show a => Show (Tree a) where
    show Leaf = "X"
    show (Node k _ l r _ c) =
        show l ++ " | (" ++ show k ++ "-" ++ show c ++ ") | " ++ show r

setColor :: Color -> Tree a -> Tree a
setColor _ Leaf               = Leaf
setColor c (Node k v l r s _) = Node k v l r s c

isRed :: Tree a -> Bool
isRed (Node _ _ _ _ _ Red) = True
isRed _                    = False

isEmpty :: Tree a -> Bool
isEmpty Leaf = True
isEmpty _    = False

resize :: Tree a -> Tree a
resize Leaf                    = Leaf
resize (Node rk rv rl rr _ rc) = Node rk rv rl rr (size rl + size rr + 1) rc

size :: Tree a -> Int
size Leaf     = 0
size n@Node{} = _size n

left :: Tree a -> Tree a
left Leaf     = Leaf
left n@Node{} = _left n

right :: Tree a -> Tree a
right Leaf     = Leaf
right n@Node{} = _right n

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
    Node k v (setColor Black l) (setColor Black r) n Red
flipColor n = n

put :: Key -> a -> Tree a -> Tree a
put k v Leaf = Node k v Leaf Leaf 1 Red
put k v (Node nk nv l r n c) =
    make & sat sa rotateLeft & sat sb rotateRight & sat sc flipColor & resize
  where
    make | k < nk    = Node nk nv (put k v l) r n c
         | k > nk    = Node nk nv l (put k v r) n c
         | otherwise = Node k v l r n c
    sa x = isRed (right x) && (not . isRed . left) x
    sb x = isRed (left x) && (isRed . left . left) x
    sc x = isRed (left x) && isRed (right x)

moveRedLeft :: Tree a -> Tree a
moveRedLeft = go . flipColor
  where
    go h@(Node k v l r n c) | (isRed . left . right) h =
        rotateLeft $ Node k v l (rotateRight r) n c
    go h = h

delMinRoot :: Tree a -> Tree a
delMinRoot Leaf = Leaf
delMinRoot root = root & sat sa (setColor Red) & delMin & sat
    (not . isEmpty)
    (setColor Black)
    where sa x = (not . isRed . left) x && (not . isRed . right) x

delMin :: Tree a -> Tree a
delMin Leaf                  = Leaf
delMin (Node _ _ Leaf _ _ _) = Leaf
delMin h =
    h
        & sat sa moveRedLeft
        & go
        & sat sb rotateLeft
        & sat sc rotateLeft
        & sat sd rotateRight
        & sat se flipColor'
        & resize
  where
    sa x = (not . isRed . left) x && (not . isRed . left . left) x
    go Leaf               = Leaf
    go (Node k v l r n c) = Node k v (delMin l) r n c
    sb x = isRed (right x)
    sc x = isRed (right x) && (not . isRed . left) x
    sd x = isRed (left x) && (isRed . left . left) x
    se x = isRed (left x) && isRed (right x)
    flipColor' (Node k v l r n c) = revert $ Node k v (revert l) (revert r) n c
      where
        revert Leaf = Leaf
        revert x    = if isRed x then setColor Black x else setColor Red x
    flipColor' x = x

delete :: Key -> Tree a -> Tree a
delete _ Leaf = Leaf
delete _ _    = undefined

deleteRoot :: Key -> Tree a -> Tree a
deleteRoot key root = root & sat sa (setColor Red) & delete key & sat
    isEmpty
    (setColor Black)
    where sa x = (not . isRed . left) x && (not . isRed . left . left) x

search :: Key -> Tree a -> Maybe a
search _ Leaf = Nothing
search key (Node k v l r _ _) | key < k   = search key l
                              | key > k   = search key r
                              | otherwise = Just v

putRoot :: Key -> a -> Tree a -> Tree a
putRoot k v t = put k v t & setColor Black

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
