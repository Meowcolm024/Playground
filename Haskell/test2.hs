data Func a b = Func {func :: a -> b}

class Appliable f where
    apply :: f a b -> a -> b

instance Appliable Func where
    apply = func

a = Func (+1) :: Func Int Int

b = Func (+)
