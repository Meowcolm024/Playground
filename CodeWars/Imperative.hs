module Imperative
  ( def,
    var,
    lit,
    while,
    (+=),
    (-=),
    (*=),
  )
where

import Control.Monad (ap, liftM)

data State s a = State {runState :: s -> (a, s)}

instance Functor (State s) where
  fmap = liftM

instance Applicative (State s) where
  pure x = State $ \y -> (x, y)
  (<*>) = ap

instance Monad (State s) where
  return = pure
  (State g) >>= f = State $ \s0 ->
    let (x, s1) = g s0
        State p = (f x)
     in p s1

evalState :: State s a -> s -> a
evalState act = fst . runState act

execState :: State s a -> s -> s
execState act = snd . runState act

type Var = State [(Pointer, Integer)] Integer

type Pointer = Either Integer Int

lkup :: Pointer -> [(Pointer, Integer)] -> Integer
lkup k@(Right _) d = case lookup k d of
  Just x -> x
  Nothing -> error "Unbounded var!"
lkup _ _ = undefined

zero :: [a]
zero = []

newMut :: Integer -> State [(Pointer, Integer)] Pointer
newMut a = State $ \xs -> (Right $ length xs, (Right $ length xs, a) : xs)

getMut :: Pointer -> Var
getMut a = State $ \xs -> (lkup a xs, xs)

modMut :: Pointer -> (Integer -> Integer) -> State [(Pointer, Integer)] ()
modMut a f = State $ \xs -> ((), change xs a)
  where
    change [] _ = []
    change (z@(yk, yv) : ys) k = if yk == a then (yk, f yv) : ys else z : change ys k

setMut :: Pointer -> Integer -> State [(Pointer, Integer)] ()
setMut a x = modMut a (const x)

while :: Pointer -> (Integer -> Bool) -> State [(Pointer, Integer)] () -> State [(Pointer, Integer)] ()
while r cond act = do
  i <- getMut r
  if cond i then act >> while r cond act else pure ()

(+=) :: Pointer -> Pointer -> State [(Pointer, Integer)] ()
x += i@(Right _) = getMut i >>= (modMut x . (+))
x += (Left i) = modMut x (+  i)

(*=) :: Pointer -> Pointer -> State [(Pointer, Integer)] ()
x *= i@(Right _) = getMut i >>= (modMut x . (*))
x *= (Left i) = modMut x (*  i)

(-=) :: Pointer -> Pointer -> State [(Pointer, Integer)] ()
x -= i@(Right _) = getMut i >>= (modMut x . (-))
x -= (Left i) = modMut x (\n -> n -  i)

lit :: Integer -> Pointer
lit = Left

def :: State [(Pointer, Integer)] Pointer -> Integer
def st = let (key, cnt) = runState st zero in 
  case key of
  Right k -> lkup (Right k) cnt
  Left k -> k

var :: Integer -> State [(Pointer, Integer)] Pointer
var = newMut

-- test :: Integer -- should be 4
test :: State [(Pointer, Integer)] Pointer
test = do
  a <- var 1
  b <- var 2
  a += b
  a += lit 1
  return a

factorial :: Integer -> Integer
factorial n = def $ do
  result <- var 1
  i <- var n
  while i (> 0) $ do
    result *= i
    i -= lit 1
  return result

howManyBetween :: Integer -> Integer -> Integer
howManyBetween c n = def $ do
  result <- var 0
  i <- var (c + 1)
  while i (< n) $ do
    result += lit 1
    i += lit 1
  return result
