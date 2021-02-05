module Vector where

data Vector
  = Rec Double Double
  | Mag Double Double
  deriving (Eq)

instance Show Vector where
  show v =
    "Vector\n Rec: {x= " ++ show (x v) ++ ", y= " ++ show (y v)
      ++ "}\n Mag: {mag= "
      ++ show (mag v)
      ++ ", rad= "
      ++ show (ang v)
      ++ ", deg= "
      ++ show ((ang v) * 180 / pi)
      ++ "}"

class VectorLike a where
  (<+>) :: a -> a -> a -- add
  (<.>) :: a -> a -> Double -- dot product
  neg :: a -> a -- negate
  convert :: a -> a -- convert form

  (<->) :: a -> a -> a -- sub
  v1 <-> v2 = v1 <+> neg v2

instance VectorLike Vector where
  (Rec x1 y1) <+> (Rec x2 y2) = Rec (x1 + x2) (y1 + y2)
  v1@Rec {} <+> v2@Mag {} = v1 <+> convert v2
  v1@Mag {} <+> v2@Rec {} = convert $ convert v1 <+> v2
  v1 <+> v2 = convert $ convert v1 <+> convert v2

  (Rec x1 y1) <.> (Rec x2 y2) = x1 * x2 + y1 * y2
  v1@Rec {} <.> v2@Mag {} = v1 <.> convert v2
  v1@Mag {} <.> v2@Rec {} = convert v1 <.> v2
  v1 <.> v2 = convert v1 <.> convert v2

  neg (Rec x y) = Rec (- x) (- y)
  neg (Mag m a) = Mag m (- a)

  convert (Rec x y) = Mag (sqrt $ x ** 2 + y ** 2) (atan (y / x))
  convert (Mag m a) = Rec (m * cos a) (m * sin a)

x :: Vector -> Double
x (Rec t _) = t
x v = x $ convert v

y :: Vector -> Double
y (Rec _ t) = t
y v = y $ convert v

mag :: Vector -> Double
mag (Mag m _) = m
mag v = mag $ convert v

ang :: Vector -> Double
ang (Mag _ a) = a
ang v = ang $ convert v

--------------------------------

r t = Rec (2.4 * t) (3 -1.2 * t ** 2)

v t = Rec 2.4 (-2.4 * t)

a t = Rec 0 (-2.4)
