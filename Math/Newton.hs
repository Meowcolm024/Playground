module Math.Newton where

import Math.Vector

move :: Double -> Vector -> Object -> Object
move t (Rec ax ay) (Object v l) = Object (convert $ Rec vx' vy') (Rec x' y')
  where
    vx = x v
    vy = y v
    vx' = vx + ax * t
    vy' = vy + ay * t
    x' = x l + vx * t + 0.5 * ax * t ** 2
    y' = y l + vy * t + 0.5 * ay * t ** 2
move t a@Mag {} o = move t (convert a) o
