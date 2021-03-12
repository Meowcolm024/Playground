import           Data.List                      ( elemIndex )
import           Data.List.Split                ( chunksOf )
import           Data.Maybe                     ( fromJust )
import           Lens.Micro
import           System.Random.Shuffle          ( shuffleM )

data Grid = Grid
    { grid :: [[Int]]
    , pos  :: (Int, Int)
    , size :: Int
    }

data Step = L | R | U | D deriving (Show)

instance Show Grid where
    show = init . unlines . map (unwords . map show) . grid

step :: Step -> Grid -> Grid
step dir p@(Grid g (x, y) s) = case dir of
    D -> if x < s - 1 then Grid (swap g (x, y) (x + 1, y)) (x + 1, y) s else p
    U -> if x > 0 then Grid (swap g (x, y) (x - 1, y)) (x - 1, y) s else p
    L -> if y > 0 then Grid (swap g (x, y) (x, y - 1)) (x, y - 1) s else p
    R -> if y < s - 1 then Grid (swap g (x, y) (x, y + 1)) (x, y + 1) s else p
  where
    swap :: [[Int]] -> (Int, Int) -> (Int, Int) -> [[Int]]
    swap mat (x1, y1) (x2, y2) =
        let a = mat !! x1 !! y1
            b = mat !! x2 !! y2
        in  mat & ix x2 . ix y2 .~ a & ix x1 . ix y1 .~ b

check :: Grid -> Bool
check (Grid g _ s) = init (concat g) == [1 .. s ^ 2 - 1]

newGrid :: Int -> IO Grid
newGrid s = do
    l <- shuffleM [0 .. s ^ 2 - 1]
    let i = fromJust (elemIndex 0 l)
    return $ Grid (chunksOf s l) (i `div` s, i `mod` s) s
