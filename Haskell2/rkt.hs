{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE UnicodeSyntax #-}

foo ∷ (∀ a. Num a ⇒ a → a) → (Int, Double) → (Int, Double)
foo f (a, b) = (f a, f b)

bar :: (forall a. Num a => a -> a) -> (Int, Double) -> (Int, Double)
bar f (a, b) = (f a, f b)
