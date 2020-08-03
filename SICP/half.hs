
search :: (Float -> Float) -> Float -> Float -> Float
search f n p | close     = m
             | val > 0   = search f n m
             | val < 0   = search f m p
             | otherwise = m
  where
    m     = (n + p) / 2
    val   = f m
    close = abs (n - p) < 0.001

halfInt :: (Float -> Float) -> Float -> Float -> Float
halfInt f a b | (x < 0) && (y > 0) = search f a b
              | (x > 0) && (y < 0) = search f b a
              | otherwise          = error "Seriously"
  where
    x = f a
    y = f b
