{-# LANGUAGE OverloadedStrings#-}
{-# LANGUAGE QuasiQuotes#-}
{-# LANGUAGE TemplateHaskell#-}
{-# LANGUAGE TypeFamilies#-}

import           Yesod

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

getHomeR = defaultLayout $ do
    setTitle "My Page Title"
    toWidget [lucius| h1 { color: green; } |]
    addScriptRemote ""
    toWidget [julius|
            function myFunction() {
                alert('hello');
            }
        |]
    toWidgetHead [hamlet|
            <meta name=keywords content="something">
        |]
    toWidget [hamlet|
            <h1>One way
        |]
    [whamlet|<h2>Another |]
    [whamlet|<p> This is some content |]
    [whamlet|<button onclick="myFunction()">Click me</button>|]
    toWidgetBody [julius|
            alert("omg!")
        |]
    footer

footer :: Widget
footer = do
    toWidget [lucius|
            footer {
                font-weight: bold;
                text-align: center
            }
        |]
    toWidget [hamlet|
            <footer>
                <p>That's all
        |]

page :: Widget
page = [whamlet|
    <p> This is my page.
    ^{footer}
|]

main = warp 3000 App
