{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}

data Zero
data Succ n

type One = Succ Zero
type Two = Succ One
type Three = Succ Two
type Four = Succ Three

zero :: Zero
zero = undefined
one :: One
one = undefined
two :: Two
two = undefined
three :: Three
three = undefined
four :: Four
four = undefined

class Pre a b | a -> b where
    pre :: a -> b
    pre = undefined

instance Pre Zero Zero
instance Pre One Zero
instance Pre (Succ a) b => Pre (Succ (Succ a)) (Succ b)

class Sub a b c | a b -> c where
    sub :: a -> b -> c
    sub = undefined

instance Sub a Zero a
instance Sub a b c => Sub (Succ a) (Succ b) c

class Add a b c | a b -> c where
    add :: a -> b -> c
    add = undefined

instance Add Zero b b
instance Add a b c => Add (Succ a) b (Succ c)

class Mul a b c | a b -> c where
    mul :: a -> b -> c
    mul = undefined

instance Mul Zero b Zero
instance (Mul a b c, Add b c d) => Mul (Succ a) b d

class Pow a b c | a b -> c where
    pow :: a -> b -> c
    pow = undefined

instance Pow a Zero One
instance (Pow a b c, Mul a c d) => Pow a (Succ b) d

{-
pow :: Nat -> Nat -> Nat
pow a 0        = 1
pow a (Succ b) = d
  where
    d = mul a c
    c = pow a b
-}

class Fac a b | a -> b where
    fac :: a -> b
    fac = undefined

instance Fac Zero One
instance (Fac n k, Mul (Succ n) k m) => Fac (Succ n) m
