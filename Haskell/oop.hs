import Data.IORef

data Figure = Figure
  { draw :: IO (),
    move :: Displacement -> IO ()
  }

type Displacement = (Int, Int)

type Point = (Int, Int)

type Radius = Int

circle :: Point -> Int -> IO Figure
circle center radius = do
  centerVar <- newIORef center

  let drawF = do
        center <- readIORef centerVar
        putStrLn $ " Circle at " ++ show center ++ " with radius " ++ show radius

  let moveF (addX, addY) = do
        (x, y) <- readIORef centerVar
        writeIORef centerVar (x + addX, y + addY)

  return $ Figure drawF moveF

rectangle :: Point -> Point -> IO Figure
rectangle from to = do
  fromVar <- newIORef from
  toVar <- newIORef to

  let drawF = do
        from <- readIORef fromVar
        to <- readIORef toVar
        putStrLn $ " Rectangle " ++ show from ++ "-" ++ show to

  let moveF (addX, addY) = do
        (fromX, fromY) <- readIORef fromVar
        (toX, toY) <- readIORef toVar
        writeIORef fromVar (fromX + addX, fromY + addY)
        writeIORef toVar (toX + addX, toY + addY)

  return $ Figure drawF moveF

drawAll :: Foldable t => t Figure -> IO ()
drawAll figures = putStrLn "Drawing figures: " >> mapM_ draw figures

main :: IO ()
main = do
  figures <- sequence [circle (10, 10) 5, rectangle (10, 10) (20, 20)]
  drawAll figures
  mapM_ (flip move (10, 10)) figures
  drawAll figures