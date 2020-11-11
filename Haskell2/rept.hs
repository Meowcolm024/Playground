import Data.List
import Control.Arrow (Arrow((&&&)))
import Data.Char (toLower)

wordCount :: String -> [(String, Int)]
wordCount = sortBy (\(_,x) (_,y) -> compare y x) . map (head &&& length) . group . sort . words . map toLower

out :: String -> [(String, Int)]
out = filter (\(_, x) -> x > 2) . wordCount 
