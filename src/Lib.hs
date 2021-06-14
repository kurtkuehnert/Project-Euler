module Lib
  ( someFunc
  ) where

import           Data.Char                      ( digitToInt )
import           Data.List

-- helper __________________________________________________________________________________________

-- >>> takeWhile ( < 100) primes
-- [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]

primes :: Integral a => [a]
primes = 2 : 3 : calcNextPrimes (tail primes) [5, 7 ..]
 where
  calcNextPrimes [] _ = []
  calcNextPrimes (p : ps) candidates =
    let (smallerSquareP, _ : biggerSquareP) = span (< p * p) candidates
    in  smallerSquareP
          ++ calcNextPrimes ps [ c | c <- biggerSquareP, rem c p /= 0 ]

-- >>> primeFactors 45
-- [3,3,5]

primeFactors :: Integral a => a -> [a]
primeFactors i = factorize i primes
 where
  factorize _ [] = error "no primes"
  factorize 1 _  = []
  factorize i (next : remaining)
    | i `mod` next == 0 = next : factorize (i `div` next) (next : remaining)
    | otherwise         = factorize i remaining

-- problem1 ________________________________________________________________________________________

-- >>> problem1
-- 233168

problem1 :: Integer
problem1 = sum [ i | i <- [1 .. 1000 - 1], i `mod` 3 == 0 || i `mod` 5 == 0 ]

-- problem2 ________________________________________________________________________________________
-- >>> problem2
-- 1089154

problem2 :: Integer
problem2 = sum $ filter even $ takeWhile (< 1000000) fibs
  where fibs = 0 : 1 : [ a + b | (a, b) <- zip fibs (tail fibs) ]

-- problem3 ________________________________________________________________________________________
-- >>> problem3
-- 6857

problem3 :: Integer
problem3 = maximum $ primeFactors 600851475143

-- problem4 ________________________________________________________________________________________
-- >>> problem4
-- 906609

problem4 :: Integer
problem4 = maximum
  [ x * y | x <- [100 .. 999], y <- [100 .. 999], isPalindrom . show $ x * y ]
  where isPalindrom x = x == reverse x

-- problem5 ________________________________________________________________________________________
-- >>> problem5
-- 232792560

problem5 :: Integer
problem5 = foldl1 lcm [1 .. 20]

-- problem6 ________________________________________________________________________________________
-- >>> problem6
-- 25164150

problem6 :: Integer
problem6 = sum [1 .. 100] ^ 2 - sum (map (^ 2) [1 .. 100])

-- problem7 ________________________________________________________________________________________
-- >>> problem7
-- 104743

problem7 :: Integer
problem7 = primes !! 10000

-- problem8 ________________________________________________________________________________________
-- >>> problem8
-- 23514624000

number :: [Char]
number =
  show
    7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450

problem8 :: Int
problem8 = greatestProduct number
 where
  greatestProduct x
    | length x < 13 = 0
    | otherwise = max (product . map digitToInt $ take 13 x)
                      (greatestProduct $ tail x)

-- problem9 ________________________________________________________________________________________
-- >>> problem9
-- 31875000

problem9 :: Integer
problem9 = head
  [ a * b * c
  | a <- [1 .. 1000]
  , b <- [a .. 1000 - a]
  , let c = 1000 - a - b
  , a ^ 2 + b ^ 2 == c ^ 2
  ]

-- problem10 _______________________________________________________________________________________

-- >>> problem10
-- 142913828922

problem10 :: Integer
problem10 = sum . takeWhile (< 2000000) $ primes

-- problem11 _______________________________________________________________________________________

-- >>> problem11
-- 76576500

problem11 :: Integer
problem11 = head . filter (\i -> divisorCount i > 500) $ scanl1 (+) [1 ..]
 where
  divisorCount = product . map (\l -> 1 + length l) . group . primeFactors

-- problem97 _______________________________________________________________________________________

-- >>> problem97
-- 8739992577

problem97 :: Integral a => a
problem97 = (2 ^ 7830457 * 28433 + 1) `mod` 10 ^ 10

-- main ____________________________________________________________________________________________
someFunc :: IO ()
someFunc = print problem97
