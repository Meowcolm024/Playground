module Stream where

import Control.Arrow ()
import Control.Applicative ()

-- import Stream.Internal

data Stream a = a :> Stream a
infixr :>

-- | Get the first element of a stream.
headS :: Stream a -> a
headS (x :> _) = x

-- | Drop the first element of a stream.
tailS :: Stream a -> Stream a
tailS (_ :> xs) = xs


-- {{{ Stream constructors

-- | Construct a stream by repeating a value.
repeatS :: a -> Stream a
repeatS x = x :> repeatS x

-- | Construct a stream by repeatedly applying a function.
iterateS :: (a -> a) -> a -> Stream a
iterateS f x = x :> iterateS f (f x)

-- | Construct a stream by repeating a list forever.
cycleS :: [a] -> Stream a
cycleS xs = go xs
    where
        go [] = go xs
        go (y:ys) = y :> go ys

-- | Construct a stream by counting numbers starting from a given one.
fromS :: Num a => a -> Stream a
fromS n = n :> fromS (n+1)

-- | Same as 'fromS', but count with a given step width.
fromStepS :: Num a => a -> a -> Stream a
fromStepS x s = x :> fromStepS (x+s) s

-- }}}


-- | Fold a stream from the left.
foldrS :: (a -> b -> b) -> Stream a -> b
foldrS f (x :> xs) = f x (foldrS f xs)

-- | Filter a stream with a predicate.
filterS :: (a -> Bool) -> Stream a -> Stream a
filterS p (x :> xs) = if p x then x :> filterS p xs else filterS p xs

-- | Take a given amount of elements from a stream.
takeS :: Int -> Stream a -> [a]
takeS i s = if i <= 0 then [] else (headS s) : takeS (i-1) (tailS s)

-- | Drop a given amount of elements from a stream.
dropS :: Int -> Stream a -> Stream a
dropS i s = if i <= 0 then s else dropS (i-1) (tailS s)

-- | Do take and drop simultaneous.
splitAtS :: Int -> Stream a -> ([a], Stream a)
splitAtS i s = (takeS i s, dropS i s)

-- | Combine two streams with a function.
zipWithS :: (a -> b -> c) -> Stream a -> Stream b -> Stream c
zipWithS f xs ys = f (headS xs) (headS ys) :> zipWithS f (tailS xs) (tailS ys)

zipS :: Stream a -> Stream b -> Stream (a, b)
zipS = zipWithS (,)

instance Functor Stream where
    -- fmap :: (a -> b) -> Stream a -> Stream b
    fmap f (x :> xs) = f x :> fmap f xs

instance Applicative Stream where
    -- pure :: a -> Stream a
    pure = repeatS

    -- (<*>) :: Stream (a -> b) -> Stream a -> Stream b
    (<*>) = go
        where
            go (f :> fs) (x :> xs) = (f x) :> go fs xs

-- | The stream of fibonacci numbers.
fibS :: Stream Integer
fibS = 0 :> 1 :> zipWithS (+) fibS (tailS fibS)

-- | The stream of prime numbers.
primeS :: Stream Integer
primeS = go primes
    where
        go (x:xs) = x :> go xs

primes :: [Integer]
primes = 2 : filter isPrime [3 ..]

isPrime :: Integer -> Bool
isPrime n = foldr (\x acc -> (x*x > n) || (n `rem` x /= 0 && acc)) False primes
