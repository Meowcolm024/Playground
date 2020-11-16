module Calculator where

fromDigits :: [Int] -> Int
fromDigits = foldl addDigit 0
   where addDigit num d = 10*num + d
