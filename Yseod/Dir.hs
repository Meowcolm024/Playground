{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import Data.Set (member)
import Data.Text (Text)
import Yesod
import Yesod.Auth
import Yesod.Auth.Dummy

data App = App

mkYesod "App" [parseRoutes|
/      HomeR  GET
/link1 Link1R GET
/link2 Link2R GET
/link3 Link3R GET
/link4 Link4R GET
|]

instance Yesod App where

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Redirects"
    [whamlet|
        <p>
            <a href=@{Link1R}>Clink to start!
    |]
    
getLink1R :: Handler Html
getLink1R = redirect Link2R
getLink2R :: Handler Html
getLink2R = redirect (Link3R, [("foo", "bar")])
getLink3R :: Handler Html
getLink3R = redirect $ Link4R :#: ("baz" :: Text)
getLink4R :: Handler Html
getLink4R = defaultLayout
    [whamlet|
        <p> You made it!
    |]

main = warp 3000 App