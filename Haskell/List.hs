data List a = Nil | Cons a (List a) deriving (Eq)

instance (Show a ) => Show (List a) where
    show Nil         = "Nil :)"
    show (Cons x xs) = show x ++ " - " ++ show xs

instance Functor List where
    fmap _ Nil         = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List where
    pure a = Cons a Nil
    Nil <*> _ = Nil
    _ <*> Nil = Nil
    (Cons f xs) <*> y = fmap f y +> (xs <*> y)

instance Monad List where
    Nil >>= _ = Nil
    Cons x xs >>= f = f x +> (xs >>= f)

instance Foldable List where
    foldr _ p Nil         = p
    foldr f p (Cons x xs) = f x (foldr f p xs)

instance Semigroup (List a) where
    (<>) = (+>)

instance Monoid (List a) where
    mempty = Nil

toList :: [a] -> List a
toList = foldr Cons Nil

-- | Like (++) in []
(+>) :: List a -> List a -> List a
x +> Nil = x
Nil +> x = x
Cons x xs +> y = Cons x (xs +> y)
