main : IO ()
main = putStrLn "Hello World"

x : Int
x = 12

IntList : Type
IntList = List Int

data Omg a = None | One a | Two a a

mapList : (a -> b) -> List a -> List b
mapList = map

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
