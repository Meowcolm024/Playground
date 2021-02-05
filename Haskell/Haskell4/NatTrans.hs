{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE RankNTypes #-}

type (~>) f g = forall x. f x -> g x

type ($|) f g = f g

type Hi = Maybe $| Either String Int

l2m :: [] ~> Maybe
l2m [] = Nothing
l2m (x:_) = Just x

m2l :: Maybe ~> []
m2l Nothing = []
m2l (Just x) = [x]

e2m :: Either a ~> Maybe
e2m (Left _) = Nothing
e2m (Right x) = Just x

e2l :: Either a ~> []
e2l =  m2l . e2m
