{-# LANGUAGE OverloadedStrings#-}
{-# LANGUAGE QuasiQuotes#-}
{-# LANGUAGE TemplateHaskell#-}
{-# LANGUAGE TypeFamilies#-}

import Yesod

data Links = Links

mkYesod "Links" [parseRoutes|
/ HomeR GET
/page1 Page1R GET
/page2 Page2R GET
|]

instance Yesod Links

getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|<a href=@{Page1R}>Go to page 1!|]

getPage1R :: Handler Html
getPage1R = defaultLayout [whamlet|<a href=@{Page2R}>Go to page 2!|]

getPage2R :: Handler Html
getPage2R = defaultLayout [whamlet|<a href=@{HomeR}>Go home!|]

main :: IO ()
main = warp 3000 Links
