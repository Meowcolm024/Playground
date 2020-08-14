data Rat = Rat Int Int

instance Show Rat where
    show (Rat x y) = show x ++ " / " ++ show y

instance Eq Rat where
    Rat a b == Rat c d = a*d == b*c

makeRat :: Int -> Int -> Rat
makeRat x y = let g = gcd x y in Rat (x `div` g) (y `div` g)

numer (Rat x _) = x
denom (Rat _ y) = y

addRat (Rat a b) (Rat c d) = makeRat (a*d+b*c) (b*d)
subRat (Rat a b) (Rat c d) = makeRat (a*d-b*c) (b*d)
mulRat (Rat a b) (Rat c d) = makeRat (a*c) (b*d)
divRat (Rat a b) (Rat c d) = makeRat (a*d) (b*c)

cons x y = dispatch
    where
        dispatch 0 = x
        dispatch 1 = y

car = ($ 0)
cdr = ($ 1)
