import Control.Monad

-------------------------------------------------------------------------------
-- State Monad Implementation
-------------------------------------------------------------------------------

newtype State s a = State {runState :: s -> (a, s)}

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

------------------------------------------------------------

newtype Pointer = Pointer Int

type MutInt = State [(Int, Int)] Int

lkup :: Eq a => a -> [(a, p)] -> p
lkup k d = case lookup k d of
  Just x -> x
  Nothing -> error "Unbounded"

zero :: [a]
zero = []

newMut :: Int -> State [(Int, Int)] Int
newMut a = State $ \xs -> (length xs, (length xs, a) : xs)

getMut :: Int -> MutInt
getMut a = State $ \xs -> (lkup a xs, xs)

modMut :: Int -> (Int -> Int) -> State [(Int, Int)] ()
modMut a f = State $ \xs -> ((), change xs a)
  where
    change [] _ = []
    change (z@(yk, yv) : ys) k = if yk == a then (yk, f yv) : ys else z : change ys k

setMut :: Int -> Int -> State [(Int, Int)] ()
setMut a x = modMut a (const x)

mutTest :: State [(Int, Int)] Int
mutTest = do
    x <- newMut 1
    modMut x (+11)
    modMut x (`div`2)
    y <- newMut 23
    getMut x >>= (setMut y . (*2))
    getMut y

main :: IO ()
main = do
  print $ evalState mutTest zero
