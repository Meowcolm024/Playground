{-# LANGUAGE MonadComprehensions#-}
import Control.Monad
import Control.Monad.IO.Class
import Control.Monad.Trans.Class
import Control.Monad.Trans.Maybe
import Control.Monad.Trans.State (State, evalState, state)
import Data.Char (isDigit)
import System.Random (Random (randomR), StdGen, mkStdGen)

rollDie :: State StdGen Int
rollDie = state $ randomR (1, 6)

rollDice :: Int -> [Int]
rollDice = flip evalState (mkStdGen 0) . flip replicateM rollDie

getP :: MaybeT IO String
getP = [s | s <- lift getLine, isValid s]

isValid :: String -> Bool
isValid = all isDigit

askP :: MaybeT IO ()
askP = do
  lift $ putStr "Insert: "
  void getP
  lift $ putStrLn "Storing..."


askfor2 :: String -> MaybeT IO String
askfor2 prompt = do
  liftIO $ putStr $ "What is your " ++ prompt ++ " (type END to quit)? "
  r <- liftIO getLine
  if r == "END"
    then MaybeT (return Nothing) -- has type: MaybeT IO String
    else MaybeT (return (Just r))
