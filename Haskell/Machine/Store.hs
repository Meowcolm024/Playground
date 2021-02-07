import Control.Monad.State

data Shop = StartS | Paied | Redeemed | Transfered | Shipped deriving (Show)

data Bank = StartB | Cancelled | Redeem | Transfer deriving (Show)

data Customer = Customer deriving (Show)

type World = State (Customer, Shop, Bank)

pay :: World ()
pay = do
  (c, s, b) <- get
  put $ case s of
    StartS -> (c, Paied, b)
    _ -> (c, s, b)

cancel :: World ()
cancel = do
  (c, s, b) <- get
  put $ case b of
    StartB -> (c, s, Cancelled)
    _ -> (c, s, b)

redeem :: World ()
redeem = do
  (c, s, b) <- get
  case s of
    Paied -> do
      put (c, Redeemed, b)
      (c, s, b) <- get
      put $ case b of
        StartB -> (c, s, Redeem)
        _ -> (c, s, b)
    _ -> put (c, s, b)

transfer :: World ()
transfer = do
  (c, s, b) <- get
  case s of
    Redeemed -> do
      put (c, Transfered, b)
      -- get updated state
      (c, s, b) <- get
      put $ case b of
        Redeem -> (c, s, Transfer)
        _ -> (c, s, b)
    _ -> put (c, s, b)

ship :: World ()
ship = do
  (c, s, b) <- get
  put $ case s of
    Transfered -> (c, Shipped, b)
    _ -> (c, s, b)

initWorld :: (Customer, Shop, Bank)
initWorld = (Customer, StartS, StartB)

worldDo :: World (Customer, Shop, Bank)
worldDo = do
  pay 
  redeem
  transfer
  ship
  get

-- >>> evalState worldDo initWorld
-- it :: ()
-- (0.01 secs, 95,288 bytes)
-- ( Customer
-- , Shipped
-- , Transfer
-- )
-- it :: (Customer, Shop, Bank)
-- (0.01 secs, 133,712 bytes)
--
