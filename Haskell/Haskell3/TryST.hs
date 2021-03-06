import Control.Monad.ST (runST)
import Data.Foldable (for_)
import Data.STRef (modifySTRef, newSTRef, readSTRef)

sumST :: (Num a, Foldable t) => t a -> a
sumST xs = runST $ do
  n <- newSTRef 0
  for_ xs $ \x ->
    modifySTRef n (+ x)
  readSTRef n
