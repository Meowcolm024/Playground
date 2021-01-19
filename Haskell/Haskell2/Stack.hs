import Control.Monad
import Debug.Trace

-------------------------------------------------------------------------------
-- State Monad Implementation
-------------------------------------------------------------------------------

newtype State s a = State { runState :: s -> (a,s) }

instance Monad (State s) where
  return a = State $ \s -> (a, s)

  State act >>= k = State $ \s ->
    let (a, s') = act s
    in runState (k a) s'

instance Applicative (State s) where
    pure = return
    (<*>) = ap

instance Functor (State s) where
    fmap = liftM

get :: State s s
get = State $ \s -> (s, s)

put :: s -> State s ()
put s = State $ \_ -> ((), s)

modify :: (s -> s) -> State s ()
modify f = get >>= \x -> put (f x)

evalState :: State s a -> s -> a
evalState act = fst . runState act

execState :: State s a -> s -> s
execState act = snd . runState act

-------------------------------------------------------------------------------
-- Example
-------------------------------------------------------------------------------

type Stack = [Int]

empty :: Stack
empty = []

pop :: State Stack Int
pop = State $ \(x:xs) -> (x,xs)

push :: Int -> State Stack ()
push a = State $ \xs -> ((),a:xs)

tos :: State Stack Int
tos = State $ \(x:xs) -> (x,x:xs)

stackManip :: State Stack Int
stackManip = do
    push 10
    push 20
    a <- pop
    b <- pop
    push (a+b)
    tos

type MutInt = Int

base :: Int
base = 0

change :: (Int -> Int) -> State MutInt ()
change f = State $ \x -> ((), f x)

-- mutIntManip :: State MutInt MutInt
mutIntManip :: State Int Int -> State Int Int
mutIntManip x = do
    x += (pure 3) 
    get

mip :: State Int Int
mip = do
    put 5
    add 3
    sub 2
    get

add v = State $ \s -> ((), s+v)
sub v = State $ \s -> ((), s-v)

(+=) = \x y -> do
    b <- x
    put b
    a <- y
    add a

(-=) = \x y -> do
    b <- x
    put b
    a <- y
    sub a

main :: IO ()
main = do
  print $ runState stackManip empty
  print $ evalState (mutIntManip (pure 5)) base
  print $ evalState mip base
 