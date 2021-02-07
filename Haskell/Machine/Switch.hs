{-# LANGUAGE LambdaCase #-}

import Control.Monad.State

data SwitchState = On | Off deriving (Show, Eq)

type Switch = State SwitchState -- what the state stores

switch :: SwitchState -> SwitchState
switch = \case
  On -> Off
  Off -> On

trigger :: Switch ()
trigger = get >>= put . switch 

initSwitch :: SwitchState
initSwitch = Off

-- simple automation using state monad
switchDo :: Switch SwitchState
switchDo = do
  trigger
  trigger
  trigger
  get -- get final state

main :: IO ()
main = print $ evalState switchDo initSwitch
