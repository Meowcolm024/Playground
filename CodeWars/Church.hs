{-# Language RankNTypes #-}
module Church (not,and,or,xor) where

import Prelude hiding (Bool,False,True,not,and,or,(&&),(||),(==),(/=))

type Boolean = forall a. a -> a -> a -- this requires RankNTypes

false,true :: Boolean
false = \ t f -> f
true  = \ t f -> t


not :: Boolean -> Boolean
and,or,xor :: Boolean -> Boolean -> Boolean

not = \ a   -> \ x y -> a y x
and = \ a b -> a b a
or  = \ a b -> a a b
xor = \ a b -> (a `or` b) `and` (not (a `and` b))