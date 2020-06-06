data Serevant = Saber | Archer | Lancer | Rider | Caster | Assassin deriving (Show, Eq)
data Atks = Weak | Resist | Normal deriving (Show)

class Rules r where
    next :: r -> r
    fight :: r -> r -> Atks
    (?>) :: r -> r -> Atks

instance Rules Serevant where
    -- upper 3
    next Saber = Lancer
    next Archer = Saber
    next Lancer = Archer
    -- lower 3
    next Rider = Caster
    next Assassin = Rider
    next Caster = Assassin
    -- funs
    fight x y | x == next y = Resist
              | y == next x = Weak
              | otherwise   = Normal
    (?>) = fight

main :: IO ()
main = do
    print $ Saber ?> Lancer
    print $ Archer `fight` Lancer
    print $ Saber ?> Saber
    print $ next Archer
    print $ next . next $ Saber
    print $ Saber ?> Rider
