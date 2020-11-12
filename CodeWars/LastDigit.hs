module LastDigit (lastDigit) where

lastDigit :: [Integer] -> Integer
lastDigit = (`rem` 10) . go
  where
    go [] = 1
    go [x] = x
    go (x : y : r)
      | odd x && odd y = x ^ (go (y : r) `rem` (x + 1))
      | odd x && even y = x ^ (foldMod y (go r) (x + 1))
      | otherwise = undefined -- ! failed

foldMod :: Integer -> Integer -> Integer -> Integer
foldMod _ 0 _ = 1
foldMod base 1 modulo = base `rem` modulo
foldMod base power modulo = (base * foldMod base (power -1) modulo) `rem` modulo
