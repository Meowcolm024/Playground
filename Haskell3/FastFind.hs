import Data.List ( sort )
import Test.QuickCheck ( (==>), quickCheck, Property )

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
fastFindK [] = 0
fastFindK [_] = 0
fastFindK xs =
  if mid > right
    then n + fastFindK (drop n xs)      -- `drop` function, drop the first n items in a list
    else fastFindK (take n xs)          -- `take` function, take the first n items in a list
  where
    n = length xs `div` 2               -- div in Haskell is same as `floor (n/2)`
    right = last xs
    mid = xs `get` n                    -- left is useless here

-- property test
-- apply `fastFindK` to a sorted list rotated k should get k
prop :: Int -> [Int] -> Property
prop k xs = (k >= 0) ==> (length xs > k) ==> fastFindK (rotate k (sort xs)) == k

main :: IO()
main = quickCheck prop
