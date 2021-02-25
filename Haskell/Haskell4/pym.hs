genPy :: Int -> [[Int]]
genPy n = [reverse x ++ tail x | i <- [1 .. n], let x = [1 .. i]]

showPy :: Int -> String
showPy n =
  let x = map (map show) (genPy n)
      y = scanl (++) "" $ map (\i -> replicate (length (head i) + 1) ' ') (reverse x)
   in unlines . reverse $ zipWith (++) y (reverse $ map unwords x)

main :: IO ()
main = putStrLn $ showPy 20
