{-# LANGUAGE OverloadedStrings #-}

import Network.Simple.TCP
import Data.ByteString

req :: ByteString
req = "GET / HTTP/1.1\nHost: www.cnn.com\n\n"
target = "cnn.com"
port = "80"

doReq :: ByteString -> HostName -> ServiceName -> IO ()
doReq requests dstAddr dstPort = do
  connect dstAddr dstPort $ \(connectionSocket, _) -> do
    send connectionSocket requests
    getBack connectionSocket

getBack :: Socket -> IO ()
getBack sSocket = do
  result <- recv sSocket 4096
  print result
  if result == Nothing
    then return ()
    else getBack sSocket
    