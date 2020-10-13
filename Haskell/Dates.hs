data Date = Date {year :: Int, month :: Int, day :: Int} deriving (Show, Eq)

instance Ord Date where
  d1 <= d2 = days d1 <= days d2

monthsLen :: Int -> [Int]
monthsLen y = if isLeap y then base 29 else base 28
  where
    base x = [31, x, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

isLeap :: Int -> Bool
isLeap n = (n `rem` 4 == 0 && n `rem` 100 /= 0) || n `rem` 400 == 0

yearLen :: Int -> Int
yearLen y = if isLeap y then 366 else 365

days :: Date -> Int
days (Date y m d) = sum (map yearLen [1 .. y -1]) + sum (take (m -1) (monthsLen y)) + d

dateDelta :: Date -> Date -> Int
dateDelta d1 d2 = days d1 - days d2

a1 :: Date
a1 = Date 2001 11 14

a2 :: Date
a2 = Date 2020 10 01

a3 :: Date
a3 = Date 2020 10 15
