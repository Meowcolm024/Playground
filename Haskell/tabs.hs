tabs :: String -> Int -> String
tabs "" _ = ""
tabs s c
  | null r = l
  | otherwise = l ++ replicate (count c (length l)) '.' ++ tabs (tail r) c
  where
    (l, r) = span (/= '\t') s
    count p q
      | p == q = p
      | p > q = p - q
      | otherwise = count p (q - p)
