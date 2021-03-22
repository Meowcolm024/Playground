{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE RankNTypes #-}

type (~>) f g = forall x . f x -> g x

type ($|) f g = f g

type Hi = Maybe $| Either String Int

class NaturalTransformable f g where
    trans :: f ~> g

instance NaturalTransformable f f where
    trans = id

instance NaturalTransformable [] Maybe where
    trans []      = Nothing
    trans (x : _) = Just x

instance NaturalTransformable Maybe [] where
    trans Nothing  = []
    trans (Just x) = [x]

instance NaturalTransformable (Either a) Maybe where
    trans (Left  _) = Nothing
    trans (Right x) = Just x
