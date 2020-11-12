{-# LANGUAGE DeriveFunctor #-}

module Imperative
  ( def,
    var,
    lit,
    while,
    (+=),
    (-=),
    (*=),
  )
where

import Control.Monad (liftM, ap)

data State s a = State {runState :: s -> (a, s)}

instance Functor (State s) where
  fmap = liftM

instance Applicative (State s) where
  pure = return
  (<*>) = ap

instance Monad (State s) where
  return x = State $ \y -> (x, y) 
  (State g) >>= f = State $ \s0 ->
      let (x, s1) = g s0
          State p = (f x)
      in p s1

data Imp a = Imp a deriving (Show, Functor)

data ImpVar a = ImpVar a deriving (Show, Functor)

def :: Imp (ImpVar a) -> Integer
def r = error "todo: def"

var :: a -> Imp (ImpVar a)
var = pure . lit

lit :: a -> (ImpVar a)
lit = pure

while :: (ImpVar a) -> (a -> Bool) -> Imp () -> Imp ()
while r f act = do
    i <- r
    if f i
        then act >> while r f act
        else return ()

(+=) :: (ImpVar a) -> b -> Imp ()
a += b = error "todo: (+=)"

(-=) :: (ImpVar a) -> b -> Imp ()
a -= b = error "todo: (-=)"

(*=) :: (ImpVar a) -> b -> Imp ()
a *= b = error "todo: (*=)"

test :: Integer -- should be 4
test = def $ do
  a <- var 1
  b <- var 2
  a += b
  a += lit 1
  return a

factorial :: Integer -> Integer
factorial n = def $ do
  result <- var 1
  i      <- var n
  while i (>0) $ do
    result *= i
    i      -= lit 1
  return result