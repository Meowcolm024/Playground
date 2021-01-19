data Tree a = Node (Tree a) a (Tree a) | Nil deriving (Show, Eq)

hello = [1, 2, 3, 4, 5, 6, 7]

b = map (+ 1) hello

f1 [] = []
f1 (x : xs) = (x + 1) : f1 xs

c = f1 hello

data List a = Lnode a (List a) | End

len End = 0
len (Lnode _ next) = 1 + len next

fib 1 = 1
fib 2 = 1
fib n = fib (n -1) + fib (n -2)

fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x : xs) = qsort left ++ [x] ++ qsort right
  where
    left = filter (<= x) xs
    right = filter (> x) xs

comb :: Integral a => a -> a -> a
comb _ 0 = 1
comb m n = go (n -1) m `div` fact n
  where
    go 0 x = x
    go y x = x * go (y -1) (x -1)
    fact 0 = 1
    fact x = product [1 .. x]

f :: Integral a => a -> a -> a
f m n = sum [comb m i * comb (n-1) (i-1) | i <- [1 .. n]]
