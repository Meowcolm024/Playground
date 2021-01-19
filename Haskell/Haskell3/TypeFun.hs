{-# LANGUAGE ExistentialQuantification #-}

data Showbox = forall s. Show s => Showbox s

instance Show Showbox where
    show (Showbox x) = show x

heteroList :: [Showbox]
heteroList = [Showbox (), Showbox (123::Int), Showbox "hello"]

data FunBox a = forall f. Functor f => FB (f a)

instance Functor FunBox where
    fmap f (FB v) = FB (fmap f v) 

fl :: [FunBox Int]
fl = [FB $ Just 2, FB $ Right 3, FB $ [2,3,4]]
