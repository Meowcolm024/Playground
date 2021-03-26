
data Nat = Zero | Succ Nat deriving (Show, Eq)

data List a = Nil | Cons a (List a) deriving (Show, Eq)

add :: Nat -> Nat -> Nat
add Zero     y = y
add (Succ x) y = add x (Succ y)

append :: List a -> List a -> List a
append Nil        y = y
append (Cons v x) y = append x (Cons v y)
