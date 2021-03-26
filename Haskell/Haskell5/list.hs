{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE RankNTypes #-}

data Nil = Nil
data Cons = Cons
data Car = Car
data Cdr = Cdr

class List f r where
    run :: f -> r

instance (a ~ Int, List (Int, f) r) => List f (Cons -> a -> r) where
    run v _ x = run (x, v)

instance a ~ Int => List (Int, f) (Car -> a) where
    run (v, _) _ = v

instance List f r => List (Int, f) (Cdr -> r) where
    run (_, x) _ = run x

-- nil :: forall r . List Nil r
-- nil = run (undefined :: Nil) 

p :: a ~ () => a
p = ()