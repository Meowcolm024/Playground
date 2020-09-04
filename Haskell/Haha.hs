data Tree a = Node (Tree a) a (Tree a) | Nil deriving (Show, Eq)

hello = [1,2,3,4,5,6,7]

b = map (+1) hello

f1 [] = []
f1 (x:xs) = (x+1):f1 xs

c = f1 hello

data List a = Lnode a (List a) | End

len End = 0
len (Lnode _ next) = 1 + len next
    
fib 1 = 1
fib 2 = 1
fib n = fib (n-1) + fib (n-2)

fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort left ++ [x] ++ qsort right
    where
        left = filter (<=x) xs
        right = filter (>x) xs

-- >>> x1
x1 :: [Integer]
x1 = [1..3]