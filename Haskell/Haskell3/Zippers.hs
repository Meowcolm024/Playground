data Node a = DeadEnd a
            | Passage a (Node a)
            | Fork    a (Node a) (Node a)
            deriving (Show)

data Branch a = KeepStraightOn a
              | TurnLeft       a (Node a)
              | TurnRight      a (Node a)
              deriving (Show)

type Thread a = [Branch a]
type Zipper a = (Thread a, Node a)

turnRight :: Zipper a -> Maybe (Zipper a)
turnRight (t, Fork x l r) = Just (TurnRight x l : t, r)
turnRight _               = Nothing

keepStraightOn :: Zipper a -> Maybe (Zipper a)
keepStraightOn (t, Passage x n) = Just (KeepStraightOn x : t, n)
keepStraightOn _                = Nothing

turnLeft :: Zipper a -> Maybe (Zipper a)
turnLeft (t, Fork x l r) = Just (TurnLeft x r : t, l)
turnLeft _               = Nothing

back :: Zipper a -> Maybe (Zipper a)
back ([]                  , _) = Nothing
back (KeepStraightOn x : t, n) = Just (t, Passage x n)
back (TurnLeft  x r    : t, l) = Just (t, Fork x l r)
back (TurnRight x l    : t, r) = Just (t, Fork x l r)
