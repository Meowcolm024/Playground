data Nat = Zero | Succ Nat deriving (Eq)

instance Show Nat where
    show = show . natInt

instance Enum Nat where
    succ = Succ
    pred Zero     = Zero
    pred (Succ x) = x
    toEnum = intNat
    fromEnum = natInt

instance Ord Nat where
    x < y = x `minus` y == Zero && x /= y
    x <= y = x `minus` y == Zero

instance Num Nat where
    (+) = add
    (-) = minus
    (*) = mult
    abs = id
    fromInteger = intNat . fromInteger
    signum Zero = 0
    signum _    = 1

natInt :: Nat -> Int
natInt Zero     = 0
natInt (Succ x) = 1 + natInt x

intNat :: Int -> Nat
intNat 0 = Zero
intNat x = Succ $ intNat (x-1)

add :: Nat -> Nat -> Nat
add x Zero     = x
add Zero x     = x
add (Succ x) y = Succ (add x y)

minus :: Nat -> Nat -> Nat
minus x Zero            = x
minus Zero _            = Zero
minus (Succ x) (Succ y) = minus x y

mult :: Nat -> Nat -> Nat
mult Zero _        = Zero
mult _ Zero        = Zero
mult x (Succ Zero) = x
mult (Succ Zero) x = x
mult a (Succ b)    = a `add` mult a b

pow :: Nat -> Nat -> Nat
pow _ Zero     = Succ Zero
pow Zero _     = Zero
pow a (Succ x) = a `mult` pow a x
