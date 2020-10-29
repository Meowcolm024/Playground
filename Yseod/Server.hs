import Network.Simple.TCP
import qualified Data.ByteString as B

main :: IO ()
main = do
    serve (Host "127.0.0.1") "8000" $ \(connectionSocket, remoteAddr) -> do
        x <- recv connectionSocket 10
        print (B.unpack <$> x)
        putStrLn $ "TCP connection established from " ++ show remoteAddr
    return ()
