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
      | otherwise = undefined -- ! failed

foldMod :: Integer -> Integer -> Integer -> Integer
foldMod _ 0 _ = 1
foldMod base 1 modulo = base `rem` modulo
foldMod base power modulo = (base * foldMod base (power -1) modulo) `rem` modulo
