data Rat = Rat Integer Integer

instance Show Rat where
    show (Rat x y) = show x ++ " / " ++ show y

instance Eq Rat where
    Rat a b == Rat c d = a*d == b*c

instance Num Rat where
    (+) = addRat
    (-) = subRat
    (*) = mulRat
    abs (Rat a b) = makeRat (abs a) (abs b)
    signum (Rat a b) = fromInteger $ signum a * signum b
    fromInteger = flip makeRat 1

instance Fractional Rat where
    recip (Rat a b) = Rat b a
    fromRational _ = undefined

makeRat :: Integer -> Integer -> Rat
makeRat x y = let g = gcd x y in Rat (x `div` g) (y `div` g)

numer :: Rat -> Integer
numer (Rat x _) = x

denom :: Rat -> Integer
denom (Rat _ y) = y

addRat :: Rat -> Rat -> Rat
addRat (Rat a b) (Rat c d) = makeRat (a*d+b*c) (b*d)

subRat :: Rat -> Rat -> Rat
subRat (Rat a b) (Rat c d) = makeRat (a*d-b*c) (b*d)

mulRat :: Rat -> Rat -> Rat
mulRat (Rat a b) (Rat c d) = makeRat (a*c) (b*d)

divRat :: Rat -> Rat -> Rat
divRat (Rat a b) (Rat c d) = makeRat (a*d) (b*c)

-----------------------------------------------------

cons :: (Eq a, Num a) => p -> p -> a -> p
cons x y = dispatch
    where
        dispatch 0 = x
        dispatch 1 = y
        dispatch _ = undefined

car :: (Integer -> b) -> b
car = ($ 0)
cdr :: (Integer -> b) -> b
cdr = ($ 1)
