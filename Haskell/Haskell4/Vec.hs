{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
-- {-# LANGUAGE FlexibleContexts #-}

data O
data S a

class Nat a
instance Nat O
instance Nat a => Nat (S a)

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

class Constructable f a where
  generate :: [b] -> f a b

-- instance Nat n => Constructable List (S n) where
--   generate (x:xs) = Cons x (generate xs)

instance Constructable List O where
  generate [] = Nil


l :: List (S (S (S O))) Int
l = Cons 1 (Cons 2 (Cons 3 Nil))

-- intToNat :: Nat * => Int -> *
-- intToNat 0 = O
-- intToNat n = S (intToNat (n-1))
