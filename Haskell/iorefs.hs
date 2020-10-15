import Control.Monad (void)
import Data.IORef

printIORef :: Show a => IORef a -> IO ()
printIORef = (>>= print) . readIORef

main :: IO ()
main = do
  arr <- newIORef (1 :: Int)
  printIORef arr
  void $ modifyIORef arr (+ 1)
  printIORef arr
  void $ writeIORef arr 233
  printIORef arr
  return ()
