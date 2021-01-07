{-# LANGUAGE ForeignFunctionInterface #-}
module Fortest where

foreign export ccall square :: Int -> Int

square x = x^2
