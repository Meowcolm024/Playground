import Control.Monad (forM_, ap, liftM )

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
  modMut x (+ 11)
  modMut x (`div` 2)
  y <- newMut 23
  getMut x >>= (setMut y . (* 2))
  getMut y

-- | foreach loop
--
-- > for == forM_
for :: Monad m => [t] -> (t -> m a) -> m ()
for [] _ = return ()
for (x : xs) act = act x >> for xs act

while :: Int -> (Int -> Bool) -> State [(Int, Int)] () -> State [(Int, Int)] ()
while r cond act = do
  i <- getMut r
  if cond i then act >> while r cond act else return ()

iff :: Monad m => Bool -> m () -> m ()
iff cond act = if cond then act else return ()

mutIOTest :: IO ()
mutIOTest = do
  x <- readLn
  y <- readLn
  print $
    flip evalState zero $ do
      v <- newMut x
      modMut v (* y)
      forM_ [1 .. y] $ \i -> do
        iff (i <= 3) $ do
          modMut v (+ i)
        iff (i > 3) $ do
          modMut v (+ x * i)
      getMut v

fact :: Int -> Int
fact n = def $ do
  v <- newMut 1
  iff (n > 0) $ do
    forM_ [1 .. n] $ \i -> do
      modMut v (* i)
  getMut v

sum' :: Int -> Int
sum' n = def $ do
  v <- newMut n
  r <- newMut 0
  while v (> 0) $ do
    r += v
    modMut v (\x -> x -1)
  getMut r

def :: State [a] c -> c
def = flip evalState zero

(+=) :: Int -> Int -> State [(Int, Int)] ()
x += i = getMut i >>= (modMut x . (+))

(*=) :: Int -> Int -> State [(Int, Int)] ()
x *= i = getMut i >>= (modMut x . (*))

(-=) :: Int -> Int -> State [(Int, Int)] ()
x -= i = getMut i >>= (modMut x . (-))

lit n = newMut n -- use something like either :)


main :: IO ()
main = do
  print $ evalState mutTest zero
  mutIOTest
