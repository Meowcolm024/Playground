{-# LANGUAGE LambdaCase #-}

module UseLens where

import Lens.Micro

data Client i
  = GovOrg i String
  | Company i String Person String
  | Individual i Person
  deriving (Show)

data Person = Person String String deriving (Show)

firstName :: Lens' Person String
firstName = lens (\(Person f _) -> f) (\(Person _ l) newF -> Person newF l)

lastName :: Lens' Person String
lastName = lens (\(Person _ l) -> l) (\(Person f _) newL -> Person f newL)

identifier :: Lens (Client i) (Client j) i j
identifier =
  lens
    ( \case
        (GovOrg i _) -> i
        (Company i _ _ _) -> i
        (Individual i _) -> i
    )
    ( \client newId -> case client of
        GovOrg _ n -> GovOrg newId n
        Company _ n p r -> Company newId n p r
        Individual _ p -> Individual newId p
    )

person :: Lens' (Client i) Person
person =
  lens
    ( \case
        (GovOrg _ _) -> undefined
        (Company _ _ p _) -> p
        (Individual _ p) -> p
    )
    ( \client newP -> case client of
        GovOrg i n -> GovOrg i n
        Company i n _ r -> Company i n newP r
        Individual i _ -> Individual i newP
    )

client :: Client Int
client = Individual 3 (Person "John" "Smith")
