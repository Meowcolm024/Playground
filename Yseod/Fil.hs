{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import           Control.Exception              ( IOException
                                                , try
                                                )
import           Control.Monad                  ( when )
import           Yesod

data App = App

instance Yesod App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

getHomeR :: Handler Html
getHomeR = do
    edata <- liftIO $ try $ readFile "output.txt"
    case edata :: Either IOException String of
        Left e -> do
            $logError "No file!"
            defaultLayout [whamlet|An error occured|]
        Right str -> do
            let ls = lines str
            when (length ls < 5) $ $logWarn "Too little!"
            defaultLayout [whamlet|
                    <ol>
                        $forall l <- ls
                            <li>#{l}
                |]

main = warp 3000 App
