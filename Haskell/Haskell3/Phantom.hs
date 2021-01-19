data Zero = Zero
data Succ a = Succ a

type D2 = Succ (Succ Zero)
type D3 = Succ D2

data Vector n a = Vector [a] deriving (Show, Eq)

vector2d :: Vector D2 Int
vector2d = Vector [1, 2]

vector3d :: Vector D3 Int
vector3d = Vector [1, 2, 3]
