{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import           Data.Time                      ( getCurrentTime )
import           Yesod

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
/error ErrorR GET
/not-found NotFoundR GET
|]

instance Yesod App where
    defaultLayout contents = do
        PageContent title headTags bodyTags <- widgetToPageContent contents
        mmsg <- getMessage
        withUrlRenderer [hamlet|
            $doctype 5
            <html>
                <head>
                    <title>#{title}
                    ^{headTags}
                <body>
                    $maybe msg <- mmsg
                        <div #message>#{msg}
                    ^{bodyTags}
        |]
    errorHandler NotFound = fmap toTypedContent $ defaultLayout $ do
        setTitle "Request page not located"
        toWidget [hamlet|
<h1>Not Found
<p>Bad news! 
<p><a href=@{HomeR}>Go Home!
|]
    errorHandler other = defaultErrorHandler other

getHomeR = do
    now <- liftIO getCurrentTime
    setMessage $ toHtml $ "Time: " ++ show now
    defaultLayout [whamlet|
        <p>Try refreshing
        <p><a href=@{ErrorR}>Go to an error Page!
        |]

getErrorR :: Handler ()
getErrorR = error "This is an error :("

getNotFoundR :: Handler ()
getNotFoundR = notFound

main :: IO ()
main = warp 3000 App
