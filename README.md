# Laboratorio 12: Programación funcional

**Teoría de la Computación**
Fatima Navarro, 24044

## Video de ejecución

[![Video del laboratorio](https://img.youtube.com/vi/oWsAwggXW14/0.jpg)](https://youtu.be/oWsAwggXW14)



## Lenguaje

Los problemas 2, 3 y 4 están resueltos en **Haskell**, un lenguaje puramente funcional basado directamente en el cálculo lambda. Todas las soluciones usan funciones lambda (`\x -> ...`) junto con funciones de orden superior (`sortBy`, `map`, `filter`).

## Estructura

```
.
├── README.md
├── src/
│   └── Main.hs          # Problemas 2, 3 y 4
└── teoria/
    └── problema1.pdf    # Problema 1: reducción β de NOT, recursión y ciclos, cuándo usar PF
```

## Cómo ejecutar

Instalar GHC (en macOS):

```bash
brew install ghc
```

Correr directamente:

```bash
runghc src/Main.hs
```

O compilar y ejecutar:

```bash
ghc -o lab12 src/Main.hs
./lab12
```

## Soluciones

### Problema 2: ordenar una lista de diccionarios por un key

```haskell
ordenarPorKey :: String -> [Diccionario] -> [Diccionario]
ordenarPorKey key = sortBy (comparing (\d -> M.lookup key d))
```

La lambda `\d -> M.lookup key d` extrae de cada diccionario el valor del key indicado, y `sortBy` ordena comparando esos valores. Cada diccionario es un `Map String Valor`, donde `Valor` puede ser texto o número para poder representar el ejemplo del enunciado.

### Problema 3: matriz transpuesta

```haskell
transpuesta :: [[a]] -> [[a]]
transpuesta = \m ->
  if null m || any null m
    then []
    else map (\fila -> head fila) m : transpuesta (map (\fila -> tail fila) m)
```

La primera columna de la matriz es la primera fila de la transpuesta (`map head`). Luego se quita esa columna (`map tail`) y se repite recursivamente hasta que no queden columnas. Funciona también con matrices no cuadradas.

### Problema 4: eliminar elementos de una lista

```haskell
eliminar :: Eq a => [a] -> [a] -> [a]
eliminar aBorrar = filter (\x -> not (x `elem` aBorrar))
```

`filter` conserva solo los elementos para los que la lambda devuelve `True`, es decir, los que **no** están en la lista a borrar. Los elementos a borrar que no existen en la lista original (como `'cafe'`) simplemente no afectan el resultado.

## Salida esperada

```
==================================================
Problema 2: ordenar diccionarios por key
==================================================
Original:
  {'make': 'Nokia', 'model': 216, 'color': 'Black'}
  {'make': 'Mi Max', 'model': 2, 'color': 'Gold'}
  {'make': 'Samsung', 'model': 7, 'color': 'Blue'}
Ordenada por key = 'model':
  {'make': 'Mi Max', 'model': 2, 'color': 'Gold'}
  {'make': 'Samsung', 'model': 7, 'color': 'Blue'}
  {'make': 'Nokia', 'model': 216, 'color': 'Black'}
Ordenada por key = 'make':
  {'make': 'Mi Max', 'model': 2, 'color': 'Gold'}
  {'make': 'Nokia', 'model': 216, 'color': 'Black'}
  {'make': 'Samsung', 'model': 7, 'color': 'Blue'}

==================================================
Problema 3: matriz transpuesta
==================================================
X   = [[1,2,3],[4,5,6],[7,8,9]]
X^T = [[1,4,7],[2,5,8],[3,6,9]]
Y (3x2)   = [[1,2],[3,4],[5,6]]
Y^T (2x3) = [[1,3,5],[2,4,6]]

==================================================
Problema 4: eliminar elementos de una lista
==================================================
Lista inicial : ["rojo","verde","azul","amarillo","gris","blanco","negro"]
A borrar      : ["amarillo","cafe","blanco"]
Resultado     : ["rojo","verde","azul","gris","negro"]
```
