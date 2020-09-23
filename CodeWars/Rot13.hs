module Rot13 where

import Data.Char

rot13 :: String -> String
rot13 = map (\x -> let y = fromEnum x in if isAscii x && isAlpha x then (if isUpper x then shiftA y else shifta y) else x)

shifta :: Int -> Char
shifta x 
    | y > 122 = toEnum $ y - 26
    | otherwise = toEnum y
    where y = x +13

shiftA :: Int -> Char
shiftA x
    | y > 90 = toEnum $ y - 26
    | otherwise = toEnum y
    where y = x + 13