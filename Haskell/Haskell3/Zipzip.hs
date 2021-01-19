data Node a = DeadEnd a
            | Passage a (Node a)
            | Fork    a (Node a) (Node a)
            deriving (Show)

data Branch = KeepStraightOn
            | TurnLeft
            | TurnRight
            deriving (Show)

type Thread = [Branch]

get :: Node a -> a
get (DeadEnd x  ) = x
get (Passage x _) = x
get (Fork x _ _ ) = x

-- correct?
put :: a -> Node a -> Node a
put x (DeadEnd _  ) = DeadEnd x
put x (Passage _ n) = Passage x n
put x (Fork _ l r ) = Fork x l r

turnRight :: Thread -> Thread
turnRight = (++ [TurnRight])

retrieve :: Thread -> Node a -> a
retrieve []                    n             = get n
retrieve (KeepStraightOn : bs) (Passage _ n) = retrieve bs n
retrieve (TurnLeft       : bs) (Fork _ l _ ) = retrieve bs l
retrieve (TurnRight      : bs) (Fork _ _ r ) = retrieve bs r
retrieve _                     _             = error "Invalid path"
