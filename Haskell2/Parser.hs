import Control.Applicative (Alternative (empty, (<|>)))
import Control.Monad (ap, liftM, void)
import Data.Char (ord, isDigit, isSpace)

newtype Parser a = Parser (String -> [(a, String)])

item :: Parser Char
item = Parser $ \cs ->
  case cs of
    "" -> []
    (x : xs) -> [(x, xs)]

instance Functor Parser where
  fmap = liftM

instance Applicative Parser where
  pure = return
  (<*>) = ap

instance Monad Parser where
  return a = Parser $ \cs -> [(a, cs)]
  p >>= f = Parser $ \cs -> concat [parse (f a) cs' | (a, cs') <- parse p cs]

parse :: Parser a -> (String -> [(a, String)])
parse (Parser p) = p

instance Monoid (Parser a) where
  mempty = Parser $ const []

instance Semigroup (Parser a) where
  p <> q = Parser $ \cs -> parse p cs <> parse q cs

instance Alternative Parser where
  empty = mempty
  p <|> q = Parser $ \cs ->
    case parse (p <> q) cs of
      [] -> []
      (x : _) -> [x]

sat :: (Char -> Bool) -> Parser Char
sat p = do
  c <- item
  if p c
    then return c
    else empty

char :: Char -> Parser Char
char = sat . (==)

string :: String -> Parser String
string "" = return ""
string (c : cs) = do
  void $ char c
  void $ string cs
  return (c : cs)

many :: Parser a -> Parser [a]
many p = many1 p <|> return []

many1 :: Parser a -> Parser [a]
many1 p = do
  a <- p
  as <- many p
  return (a : as)

sepBy :: Parser a1 -> Parser a2 -> Parser [a1]
p `sepBy` sep = (p `sepBy1` sep) <|> return []

sepBy1 :: Parser a1 -> Parser a2 -> Parser [a1]
p `sepBy1` sep = do
  a <- p
  as <- many $ sep >> p
  return (a : as)

chain :: Parser a -> Parser (a -> a -> a) -> a -> Parser a
chain p op a = (p `chain1` op) <|> return a

chain1 :: Parser a -> Parser (a -> a -> a) -> Parser a
p `chain1` op = do
  a <- p
  rest a
  where
    rest a = g a <|> return a
    g a = do
      f <- op
      b <- p
      rest (f a b)

space :: Parser [Char]
space = many (sat isSpace)

token :: Parser b -> Parser b
token p = do
    a <- p
    void space
    return a

symb :: String -> Parser String
symb = token . string

apply :: Parser a -> String -> [(a, String)]
apply = parse . (space >>)

expr :: Parser Int
expr = term `chain1` addop

term :: Parser Int
term = factor `chain1` mulop

factor :: Parser Int
factor = digit <|> do
    void $ symb "("
    n <- expr
    void $ symb ")"
    return n

digit :: Parser Int
digit = (\x -> ord x - ord '0') <$> token (sat isDigit)

addop :: Parser (Int -> Int -> Int)
addop = (symb "+" >> return (+)) <|> (symb "-" >> return (-))

mulop :: Parser (Int -> Int -> Int)
mulop = (symb "*" >> return (*)) <|> (symb "/" >> return div)
