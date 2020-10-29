import Network.Simple.TCP
import qualified Data.ByteString as B
import Data.Word (Word8)

main :: IO ()
main = do
    connect "127.0.0.1" "8000" $ \(connectionSocket, remoteAddr) -> do
        send connectionSocket (B.pack [0,1,2,3])
        putStrLn $ "Connection established to " ++ show remoteAddr
    return ()

sendbytes :: [Word8] -> IO ()
sendbytes xs = do
    connect "127.0.0.1" "8000" $ \(connectionSocket, remoteAddr) -> do
        send connectionSocket (B.pack xs)
        putStrLn $ "Connection established to " ++ show remoteAddr
    return ()