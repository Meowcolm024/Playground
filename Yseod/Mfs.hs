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
/pwd PassR GET
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

passwordConfirmField :: Field Handler Text
passwordConfirmField = Field
    {
        fieldParse = \rawVals _fileVals ->
            case rawVals of
                [a, b] | a == b -> return $ Right (Just a)
                       | otherwise -> return $ Left "Password don't match!"
                [] -> return $ Right Nothing 
                _ -> return $ Left "You must enter two values"
    ,   fieldView = \idAttr nameAttr otherAttr eResult isReq ->
            [whamlet|
                <input id=#{idAttr} name=#{nameAttr} *{otherAttr} type=password>
                <div>Confirm:
                <input id=#{idAttr}-confirm name=#{nameAttr} *{otherAttr} type=password>
            |]
    , fieldEnctype = UrlEncoded 
    }

getHomeR :: Handler Html
getHomeR = do
    ((res, widget), enctype) <- runFormGet personForm
    defaultLayout [whamlet|
            <p> Result: #{show res}
            <form enctype=#{enctype}>
                ^{widget}
            <p> <a href=@{PassR}>Go to change password!
        |]

getPassR :: Handler Html 
getPassR = do
    ((res, widget), enctype) <- runFormGet $ renderDivs $ areq passwordConfirmField "Password" Nothing
    defaultLayout
        [whamlet|
            <p>Result: #{show res}
            <form enctype=#{enctype}>
                ^{widget}
                <input type=submit value="Change password">
            <p> <a href=@{HomeR}> Go Home!
        |]

main :: IO ()
main = warp 3000 App
