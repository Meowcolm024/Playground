module LastDigit (lastDigit) where

lastDigit :: [Integer] -> Integer
lastDigit [] = 1
lastDigit (1 : _) = 1
lastDigit as = (`rem` 10) $ powerRem as

powerRem :: [Integer] -> Integer
powerRem = go
  where
    go [] = 1
    go [x] = x
    go (x : y : r)
      | odd x && odd y = x ^ (go (y : r) `rem` (x + 1))
      | odd x && even y = x ^ (foldMod y (powerRem r) (x + 1))
      | otherwise = ldPower (ld' x) $ powerRem (y : r) -- ! failed

foldMod :: Integer -> Integer -> Integer -> Integer
foldMod _ 0 _ = 1
foldMod base 1 modulo = base `rem` modulo
foldMod base power modulo = (base * foldMod base (power -1) modulo) `rem` modulo

ldPower :: Integer -> Integer -> Integer
ldPower 0 x = if even (ld x 0) then 1 else 0
ldPower 2 x = [1, 2, 4, 8, 6] !! (ld x 2)
ldPower 4 x = [1, 4, 6] !! (ld x 4)
ldPower 6 x = [1, 6, 6] !! (ld x 6)
ldPower 8 x = [1, 8, 4, 2, 6] !! (ld x 8)
ldPower 10 _ = 10
ldPower _ _ = error "???"

ld :: Integer -> Int -> Int
ld n m =
    if x == "0"
       then 0
       else let p = read x `rem` g m in if p == 0 then g m else p
  where 
      x = reverse . take 2 . reverse $ show n
      g 8 = 4
      g 6 = 2
      g 4 = 2
      g 2 = 4
      g 0 = 2
      g _ = undefined

ld' :: Integer -> Integer
ld' n =
  let x = reverse . take 2 . reverse $ show n
   in if x == "0"
       then 0
       else read x `rem` 10