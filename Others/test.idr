x : Int
x = 12

IntList : Type
IntList = List Int

data Omg a = None | One a | Two a a

mapList : (a -> b) -> List a -> List b
mapList = map

Functor Omg where
    map _ None = None
    map f (One x) = One (f x)
    map f (Two x y) = Two (f x) (f y)

O : Type
S : Type -> Type

intToNat : Int -> Type
intToNat 0 = O
intToNat n = S (intToNat (n-1))

data Vec : Type -> (a : Type) -> Type where
    Nil : Vec O a
    Cons : a -> Vec n a -> Vec (S n) a

helper : List a -> Type
helper [] = O
helper (_::n) = S (helper n)

fromList : (n: List a) -> Vec (helper n) a
fromList [] = Nil
fromList (x::xs) = Cons x (fromList xs)

mutual 
    mapSq : List Int -> List Int
    mapSq = mapList square

    square : Int -> Int
    square x = x*x

unit : a -> ()
unit _ = ()

MyType : Type
MyType = (Int, Int)

mutual
    isOdd : Int -> Bool
    isOdd 0 = False
    isOdd n = isEven (n-1)

    isEven : Int -> Bool
    isEven 0 = True
    isEven n = isOdd (n-1)

main : IO ()
main = putStrLn "Hello World"
