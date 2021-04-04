{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import           Control.Arrow                  ( (&&&) )
import           Data.Text                      ( Text
                                                , pack
                                                )
import           Data.Time                      ( getCurrentTime
                                                , toGregorian
                                                , utctDay
                                                )
import           Yesod
import           Yesod.Form.Jquery

data App = App
mkYesod "App" [parseRoutes|
/ HomeR GET
/car CarR POST
|]

instance Yesod App

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

instance YesodJquery App

data Car = Car
    { carModel :: Text
    , carYear  :: Int
    , carColor :: Maybe Color
    }
    deriving Show

data Color = Red | Blue | Gray | Black deriving (Show, Eq, Enum, Bounded)

carAForm :: Maybe Car -> AForm Handler Car
carAForm mcar =
    Car
        <$> areq textField    "Model" (carModel <$> mcar)
        <*> areq carYearField "Year"  (carYear <$> mcar)
        <*> aopt (selectFieldList colors) "Color" (carColor <$> mcar)
  where
    colors = map (pack . show &&& id) [minBound .. maxBound]
    carYearField =
        checkM inPast $ checkBool (>= 1990) ("Too Old!" :: Text) intField
    inPast y = do
        thisYear <- liftIO getCurrentYear
        return $ if y <= thisYear
            then Right y
            else Left ("You have a time machine!" :: Text)
    getCurrentYear = do
        now <- getCurrentTime
        let (year, _, _) = toGregorian (utctDay now)
        return $ fromInteger year

carForm = renderDivs $ carAForm $ Just (Car ("Tesla" :: Text) 2020 (Just Red))

getHomeR :: Handler Html
getHomeR = do
    (widget, enctype) <- generateFormPost carForm
    defaultLayout [whamlet|
            <p> 
                Aha!
            <form method=post action=@{CarR} enctype=#{enctype}>
                ^{widget}
                <button>Submit
        |]

postCarR :: Handler Html
postCarR = do
    ((result, _), _) <- runFormPost carForm
    case result of
        FormSuccess car -> defaultLayout [whamlet|<p>#{show car}|]
        FormFailure err    -> defaultLayout [whamlet|<p>error #{show err}|]
        FormMissing        -> defaultLayout [whamlet|<p>Form missing|]

main :: IO ()
main = warp 3000 App
