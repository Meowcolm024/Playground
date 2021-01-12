module Maybe =
    type 'a Maybe =
        | Nothing
        | Just of 'a

    // functor
    let fmap f x =
        match x with
        | Just a -> Just(f a)
        | Nothing -> Nothing

    let (<^>) = fmap

    // applicative
    let ``pure`` x = Just x

    let (<*>) f x =
        match (f, x) with
        | (Just g, Just y) -> Just(g y)
        | _ -> Nothing

    // monad
    let (>>=) x f =
        match x with
        | Just y -> f y
        | Nothing -> Nothing

    // alternative
    let (<|>) a b =
        match (a, b) with
        | (Just _, _) -> a
        | (Nothing, _) -> b

module Identity =
    type 'a Identity = Identity of 'a

    let runIdentity x =
        match x with
        | Identity y -> y

    let fmap f x =
        match x with
        | Identity a -> Identity(f a)

module Const =
    type Const<'a, 'b> = Const of 'a

    let unConst x =
        match x with
        | Const y -> y

    let fmap (_: 'a -> 'c) (x: Const<'a, 'b>) = x
