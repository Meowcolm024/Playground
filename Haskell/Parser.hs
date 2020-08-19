{-#LANGUAGE LambdaCase#-}
{-#LANGUAGE TypeSynonymInstances#-}

type Parser a = String -> [(a, String)]

parse :: Parser a -> String -> [(a, String)]
parse = ($)

failure = const []

item = \case
    [] -> []
    (x:xs) -> [(x,xs)]
