main : IO ()
main = putStrLn "Hello World"

x : Int
x = 12

IntList : Type
IntList = List Int

data Omg a = None | One a | Two a a

mapList : (a -> b) -> List a -> List b
mapList = map

unit : a -> ()
unit _ = ()
