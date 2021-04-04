{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import           Data.Text                      ( Text )
import           Data.Time                      ( Day )
import           Yesod
import           Yesod.Form.Jquery

data App = App
mkYesod "App" [parseRoutes|
/ HomeR GET
/person PersonR POST
|]

instance Yesod App

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

instance YesodJquery App

data Person = Person
    { personName          :: Text
    , personBirthday      :: Day
    , personFavoriteColor :: Maybe Text
    , personEmail         :: Text
    , personWebsite       :: Maybe Text
    }
    deriving Show

personForm :: Html -> MForm Handler (FormResult Person, Widget)
personForm =
    renderDivs
        $   Person
        <$> areq textField "Name" Nothing
        <*> areq
                (jqueryDayField def { jdsChangeYear = True
                                    , jdsYearRange  = "1900:-5"
                                    })
                "Birthday"
                Nothing
        <*> aopt textField "Favorite color" Nothing
        <*> areq emailField "Email Address" Nothing
        <*> aopt urlField "Website" Nothing

getHomeR :: Handler Html
getHomeR = do
    (widget, enctype) <- generateFormPost personForm
    defaultLayout [whamlet|
            <p> 
                Aha!
            <form method=post action=@{PersonR} enctype=#{enctype}>
                ^{widget}
                <p>We need a submit button!
                <button>Submit
        |]

postPersonR :: Handler Html
postPersonR = do
    ((result, widget), enctype) <- runFormPost personForm
    case result of
        FormSuccess person -> defaultLayout [whamlet|<p>#{show person}|]
        _ -> defaultLayout [whamlet|
                    <p>Invalid input, try again!
                    <form method=post action=@{PersonR} enctype=#{enctype}>
                        ^{widget}
                        <button>Submit
                |]

main :: IO ()
main = warp 3000 App
