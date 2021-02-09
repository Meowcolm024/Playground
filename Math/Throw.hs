module Throw where

import Math.Newton
import Math.Vector

g :: Double
g = 9.81

horiz :: Object -> Object
horiz (Object (Mag v a) (Rec x y)) = Object (Mag vx 0) (Rec (x + hx) (y + hy))
  where
    vy = v * sin a
    vx = v * cos a
    t = vy / g
    hy = vy ** 2 / (2 * g)
    hx = vx * t
horiz (Object v l@Mag {}) = horiz $ Object v (convert l)
horiz (Object v@Rec {} l) = horiz $ Object (convert v) l

ground :: Object -> Maybe Object
ground o@(Object v p) =
  if y p < 0
    then Nothing
    else Just $ Object (convert $ Rec vx vy) (Rec (px + s) 0)
  where
    Object (Mag v a) (Rec px py) = horiz o
    vx = v * cos a
    t = sqrt $ (2 * py) / g
    s = vx * t
    vy = g * t

time :: Double -> Object -> Object
time t = move t (Rec 0 g)
