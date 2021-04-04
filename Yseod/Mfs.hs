{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import           Data.Text                      ( Text )
import           Yesod

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

data Person = Person
    { personName :: Text
    , personAge  :: Int
    }
    deriving Show

personForm :: Html -> MForm Handler (FormResult Person, Widget)
personForm extra = do
    (nameRes, nameView) <- mreq textField "now used!" Nothing
    (ageRes , ageView ) <- mreq intField "neither" Nothing
    let personRes = Person <$> nameRes <*> ageRes
    let widget = do
            toWidget [lucius|
                ##{fvId ageView} {
                    width: 3em;
                }
            |]
            [whamlet|
            #{extra}
            <p>
                Hello, my name is #
                ^{fvInput nameView}
                \ and I am #
                ^{fvInput ageView}
                \ years old. #
                <input type=submit value="Introduce myself">
        |]
    return (personRes, widget)

getHomeR :: Handler Html
getHomeR = do
    ((res, widget), enctype) <- runFormGet personForm
    defaultLayout [whamlet|
            <p> Result: #{show res}
            <form enctype=#{enctype}>
                ^{widget}
        |]

main :: IO ()
main = warp 3000 App
