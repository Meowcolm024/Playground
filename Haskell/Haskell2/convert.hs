import Control.Monad (ap)
import Data.Function (fix)
import Test.Hspec (describe, hspec, it, shouldBe)

toDec :: Int -> String -> Int
toDec base = ap (fix $ \f xs l -> if l == 0 then 0 else head xs * base ^ (l -1) + f (tail xs) (l -1)) length . map ((\x -> if x > 64 then x - 55 else x - 48) . fromEnum)

toBase :: Int -> Int -> String
toBase base = map (\x -> toEnum $ if x < 10 then x + 48 else x + 55) . (reverse . fix (\f n -> let (q, r) = n `divMod` base in if q == 0 then pure r else r : f q))

baseToBase :: Int -> Int -> String -> String
baseToBase f t = toBase t . toDec f

main :: IO ()
main = hspec spec

spec = do
  describe "convertBase" $ do
    it "should work on simple examples" $ do
      baseToBase 2 10 "110110" `shouldBe` "54"
      baseToBase 16 10 "FF" `shouldBe` "255"
      baseToBase 21 17 "G0J1" `shouldBe` "1D41D"
      baseToBase 32 18 "HELLO" `shouldBe` "9C7056"
      baseToBase 35 24 "FGO" `shouldBe` "18LN"
      baseToBase 5 29 "22332233" `shouldBe` "84KC"
      baseToBase 13 4 "123ABC" `shouldBe` "1222221303"
