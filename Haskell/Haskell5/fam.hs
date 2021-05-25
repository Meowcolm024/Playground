{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE RankNTypes #-}

data Male
    
male :: Male
male = undefined 

data Female

female ::Female
female = undefined 

class Gender a

instance Gender Male
instance Gender Female

class (Gender a, Gender b) => Couple a b | a -> b where
    couple :: a -> b -> ()
    couple = undefined 

instance Couple Male Female
instance Couple Female Male
