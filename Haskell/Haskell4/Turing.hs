module Turing where

data State = L | R | I | O

data Machine = Machine {
    start :: Int,
    halt :: Int,
    position :: Int,
    tape :: [Int]
} deriving Show

