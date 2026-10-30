-- Laboratorio 12 - Teoria de la Computacion
-- Fatima Navarro - 24044
-- Problemas 2, 3 y 4 resueltos con funciones lambda en Haskell.

module Main where

import Data.List (sortBy)
import Data.Ord (comparing)
import qualified Data.Map as M

-- ============================================================
-- Tipos auxiliares
-- Un "diccionario" es un Map de String a Valor, donde un valor
-- puede ser texto o numero (como en el ejemplo del enunciado).
-- ============================================================

data Valor = Texto String | Numero Int
  deriving (Eq, Ord)

instance Show Valor where
  show (Texto s)  = "'" ++ s ++ "'"
  show (Numero n) = show n

type Diccionario = M.Map String Valor

mostrarDic :: [String] -> Diccionario -> String
mostrarDic orden d =
  "{" ++ concatMap' ", " (map (\k -> "'" ++ k ++ "': " ++ maybe "None" show (M.lookup k d)) orden) ++ "}"
  where
    concatMap' sep = foldr1 (\a b -> a ++ sep ++ b)

-- ============================================================
-- Problema 2: ordenar lista de diccionarios por un key
-- ============================================================

ordenarPorKey :: String -> [Diccionario] -> [Diccionario]
ordenarPorKey key = sortBy (comparing (\d -> M.lookup key d))

-- ============================================================
-- Problema 3: matriz transpuesta
-- Caso base: si alguna fila esta vacia, no hay mas columnas.
-- Paso: la primera columna es (map head), el resto es
-- la transpuesta de (map tail).
-- ============================================================

transpuesta :: [[a]] -> [[a]]
transpuesta = \m ->
  if null m || any null m
    then []
    else map (\fila -> head fila) m : transpuesta (map (\fila -> tail fila) m)

-- ============================================================
-- Problema 4: eliminar elementos indicados de una lista
-- ============================================================

eliminar :: Eq a => [a] -> [a] -> [a]
eliminar aBorrar = filter (\x -> not (x `elem` aBorrar))

-- ============================================================
-- Main: corre los tres ejemplos del enunciado
-- ============================================================

separador :: String -> IO ()
separador titulo = do
  putStrLn ""
  putStrLn (replicate 50 '=')
  putStrLn titulo
  putStrLn (replicate 50 '=')

main :: IO ()
main = do
  -- Problema 2
  separador "Problema 2: ordenar diccionarios por key"
  let telefonos =
        [ M.fromList [("make", Texto "Nokia"),   ("model", Numero 216), ("color", Texto "Black")]
        , M.fromList [("make", Texto "Mi Max"),  ("model", Numero 2),   ("color", Texto "Gold")]
        , M.fromList [("make", Texto "Samsung"), ("model", Numero 7),   ("color", Texto "Blue")]
        ]
      campos = ["make", "model", "color"]
      imprimir = mapM_ (\d -> putStrLn ("  " ++ mostrarDic campos d))
  putStrLn "Original:"
  imprimir telefonos
  putStrLn "Ordenada por key = 'model':"
  imprimir (ordenarPorKey "model" telefonos)
  putStrLn "Ordenada por key = 'make':"
  imprimir (ordenarPorKey "make" telefonos)

  -- Problema 3
  separador "Problema 3: matriz transpuesta"
  let x = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] :: [[Int]]
  putStrLn ("X   = " ++ show x)
  putStrLn ("X^T = " ++ show (transpuesta x))
  let y = [[1, 2], [3, 4], [5, 6]] :: [[Int]]
  putStrLn ("Y (3x2)   = " ++ show y)
  putStrLn ("Y^T (2x3) = " ++ show (transpuesta y))

  -- Problema 4
  separador "Problema 4: eliminar elementos de una lista"
  let colores = ["rojo", "verde", "azul", "amarillo", "gris", "blanco", "negro"]
      borrar  = ["amarillo", "cafe", "blanco"]
  putStrLn ("Lista inicial : " ++ show colores)
  putStrLn ("A borrar      : " ++ show borrar)
  putStrLn ("Resultado     : " ++ show (eliminar borrar colores))
