data Nat = Z | S Nat deriving (Eq)

data Sign = P Nat | N Nat deriving (Show)

data Rat = Sign :|: Sign deriving (Show, Eq)

instance Show Nat where
  show = show . fromEnum

instance Ord Nat where
  compare Z Z = EQ
  compare Z (S _) = LT
  compare (S _) Z = GT
  compare (S x) (S y) = compare x y

instance Enum Nat where
  toEnum 0 = Z
  toEnum x = S $ toEnum (x -1)
  fromEnum Z = 0
  fromEnum (S x) = 1 + fromEnum x

instance Eq Sign where
  (P Z) == (N Z) = True
  (N Z) == (P Z) = True
  (P x) == (P y) = x == y
  (N x) == (N y) = x == y
  _ == _ = False

instance Num Sign where
  (+) = add
  (*) = mul
  negate (P x) = N x
  negate (N x) = P x
  signum (P Z) = 0
  signum (N Z) = 0
  signum (P _) = 1
  signum (N _) = -1
  abs (P x) = P x
  abs (N x) = P x
  fromInteger x
    | x == 0 = P Z
    | x < 0 = N $ f (- x)
    | otherwise = P $ f x
    where
      f 0 = Z
      f t = S $ f (t -1)

addNat :: Nat -> Nat -> Nat
addNat Z x = x
addNat x Z = x
addNat (S x) y = S $ addNat x y

subNat :: Nat -> Nat -> Nat
subNat Z _ = Z
subNat s@(S _) Z = s
subNat (S x) (S y) = subNat x y

mulNat :: Nat -> Nat -> Nat
mulNat Z _ = Z
mulNat _ Z = Z
mulNat x y = addNat x (mulNat x (pred y))

add :: Sign -> Sign -> Sign
add (P Z) x = x
add (N Z) x = x
add x (P Z) = x
add x (N Z) = x
add (P x) (P y) = P $ addNat x y
add (N x) (N y) = N $ addNat x y
add (P x) (N y) = case compare x y of
  EQ -> P Z
  LT -> N $ subNat y x
  GT -> P $ subNat x y
add (N y) (P x) = case compare x y of
  EQ -> P Z
  LT -> N $ subNat y x
  GT -> P $ subNat x y

mul :: Sign -> Sign -> Sign
mul (N x) (N y) = P $ mulNat x y
mul (N x) (P y) = N $ mulNat x y
mul (P x) (N y) = N $ mulNat x y
mul (P x) (P y) = P $ mulNat x y
