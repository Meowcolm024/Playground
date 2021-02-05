{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}

data O

data S a

class Nat a

instance Nat O

instance Nat a => Nat (S a)

newtype Vec n x = Vec {unVec :: [x]} deriving (Show)

vec2D :: Int -> Int -> Vec (S (S O)) Int
vec2D x y = Vec [x, y]

vec3D :: Int -> Int -> Int -> Vec (S (S (S O))) Int
vec3D x y z = Vec [x, y, z]

(<+>) :: (Nat a, Num b) => Vec a b -> Vec a b -> Vec a b
v1 <+> v2 = Vec $ zipWith (+) (unVec v1) (unVec v2)

(<->) :: (Nat a, Num b) => Vec a b -> Vec a b -> Vec a b
v1 <-> v2 = Vec $ zipWith (-) (unVec v1) (unVec v2)

(<.>) :: (Nat a, Num b) => Vec a b -> Vec a b -> b
v1 <.> v2 = sum $ zipWith (*) (unVec v1) (unVec v2)

(<@>) :: (Nat a, Num b) => Vec a b -> Vec a b -> Vec (S a) b
(Vec [a, b]) <@> (Vec [c, d]) = Vec $ [0, 0, a * d - b * c]
_ <@> _ = undefined

data List n a where
  Nil :: List O a
  Cons :: Nat n => a -> List n a -> List (S n) a

head' :: Nat n => List (S n) x -> x
head' (Cons x _) = x

tail' :: Nat n => List (S n) x -> List n x
tail' (Cons _ xs) = xs

class Len f where
  len :: f a -> Int

instance Nat n => Len (List n) where
  len Nil = 0
  len (Cons _ xs) = 1 + len xs 

l :: List (S (S (S O))) Int
l = Cons 1 (Cons 2 (Cons 3 Nil))
