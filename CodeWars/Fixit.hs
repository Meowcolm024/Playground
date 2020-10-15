module Fixit where

fix :: (t -> t) -> t
fix f = let x = f x in x

reverse' :: ([a] -> [a]) -> [a] -> [a]
reverse' f a = if null a then [] else f (tail a) ++ [head a]

foldr' :: ((a -> b -> b) -> b -> [a] -> b) -> (a -> b -> b) -> b -> [a] -> b
foldr' f g b xs =
  if null xs
    then b
    else g (head xs) (f g b (tail xs))
