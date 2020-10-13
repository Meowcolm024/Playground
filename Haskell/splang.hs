data Val = Atom String
         | Number Int
         | Str String
         | Boolean Bool
         | List [Val]
         | PreFunc ([Val] -> Val)
         | Function {args :: [Val], body :: [Val]}

instance Show Val where
    show (Atom x) = x
    show (Number x) = show x
    show (Str x) = x
    show (Boolean x) = show x
    show (List x) = foldr (\p acc -> show p ++ " " ++ acc) [] x
    show (PreFunc _) = "<Primitive function>"
    show (Function _ _) = "<Function>"

