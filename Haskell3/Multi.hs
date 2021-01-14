{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

class Eq e => Collection c e where
  insert :: e -> c -> c
  member :: e -> c -> Bool

instance Eq a => Collection [a] a where
  insert = (:)
  member = elem

data Complex = Complex Int Int deriving (Show, Eq)

class Mult a b c | a b -> c where
    mult :: a -> b -> c

instance Mult Complex Int Complex where
    (Complex r i) `mult` x = Complex (r*x) (i*x)

instance Mult Complex Complex Complex where
    (Complex a b) `mult` (Complex c d) = Complex (a*c-b*d) (b*c+a*d)
