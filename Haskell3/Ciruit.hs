{-# LANGUAGE Arrows #-}

import Control.Arrow
import qualified Control.Category as Cat
import System.Random

newtype Circuit a b = Circuit {unCircuit :: a -> (Circuit a b, b)}

instance Cat.Category Circuit where
  id = Circuit $ \a -> (Cat.id, a)
  (.) = dot
    where
      (Circuit cir2) `dot` (Circuit cir1) = Circuit $ \a ->
        let (cir1', b) = cir1 a
            (cir2', c) = cir2 b
         in (cir2' `dot` cir1', c)

instance Arrow Circuit where
  arr f = Circuit $ \a -> (arr f, f a)
  first (Circuit cir) =
    Circuit $ \(b, d) -> let (cir', c) = cir b in (first cir', (c, d))

runCircuit :: Circuit a1 a2 -> [a1] -> [a2]
runCircuit _ [] = []
runCircuit cir (x : xs) =
  let (cir', x') = unCircuit cir x in x' : runCircuit cir' xs

accum :: t -> (a -> t -> (b, t)) -> Circuit a b
accum acc f = Circuit $ \input ->
  let (output, acc') = input `f` acc
   in (accum acc' f, output)

accum' :: t -> (a -> t -> t) -> Circuit a t
accum' acc f = accum acc (\a b -> let b' = a `f` b in (b', b'))

total :: Num a => Circuit a a
total = accum' 0 (+)

mean1 :: Circuit Double Double
mean1 = (total &&& (const 1 ^>> total)) >>> arr (uncurry (/))

mean2 :: Circuit Double Double
mean2 = proc value -> do
  t <- total -< value
  n <- total -< 1
  returnA -< t / n

generator :: Random a => (a, a) -> StdGen -> Circuit () a
generator range rng = accum rng $ \_ rng -> randomR range rng

dictionary :: [String]
dictionary = ["dog", "cat", "bird"]

pickWord :: StdGen -> Circuit () String
pickWord rng = proc () -> do
  idx <- generator (0, length dictionary - 1) rng -< ()
  returnA -< dictionary !! idx

oneShot :: Circuit () Bool
oneShot = accum True $ \_ acc -> (acc, False)

delayedEcho :: b -> Circuit b b
delayedEcho acc = accum acc (flip (,))

