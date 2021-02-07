import Control.Monad.State
import Lens.Micro

data Direction = L | R deriving Show

type Data = Maybe Int
type Pos = Int
type Stage = Int
type Tape = [Int]

type Turing = State (Pos, Tape)
