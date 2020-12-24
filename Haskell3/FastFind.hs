import Control.Monad (forM_)
import Data.List (sort)
import Test.QuickCheck (Property, quickCheck, (==>))

-- | gen
--
-- get the i-th item of the list
get :: [a] -> Int -> a
get xs n = xs !! (n -1)

-- | rotate
--
-- rotate the list as described in the question
rotate :: Int -> [a] -> [a]
rotate k xs = let n = length xs - k in drop n xs ++ take n xs

-- | fasetFindK
--
-- the fastFindK answerwed implemented in Haskell (log n)
fastFindK :: [Int] -> Int
fastFindK [] = 0 -- case for an empty list
fastFindK [_] = 0 -- case for a singleton list
fastFindK xs =
  if mid > right
    then n + fastFindK (drop n xs) -- `drop` function, drop the first n items in a list
    else fastFindK (take n xs) -- `take` function, take the first n items in a list
  where
    n = length xs `div` 2 -- div in Haskell is same as `floor (n/2)`
    right = last xs -- get the last item
    mid = xs `get` n -- get the n-th item (the middle one), left is useless here

-- property test
-- apply `fastFindK` to a sorted list rotated k should get k
prop :: Int -> [Int] -> Property
prop k xs = (k >= 0) ==> (length xs > k) ==> fastFindK (rotate k (sort xs)) == k

-- only fails when there're duplicate items in the list
main :: IO ()
main = forM_ [1 .. 10] $ const $ quickCheck prop

-- test result:
-- ! only fails when there're duplicate items in the list
{--------------------------------------------------------
λ> mapM_ (const main) [1..10]
+++ OK, passed 100 tests; 257 discarded.
+++ OK, passed 100 tests; 354 discarded.
+++ OK, passed 100 tests; 371 discarded.
+++ OK, passed 100 tests; 366 discarded.
+++ OK, passed 100 tests; 326 discarded.
+++ OK, passed 100 tests; 292 discarded.
*** Failed! Falsified (after 6 tests and 1 shrink):
2
[0,-1,-1]
*** Failed! Falsified (after 4 tests and 1 shrink):
1
[2,2]
*** Failed! Falsified (after 21 tests and 2 shrinks):
2
[-7,0,-7]
*** Failed! Falsified (after 3 tests):
1
[-2,-2] 
--------------------------------------------------------}
