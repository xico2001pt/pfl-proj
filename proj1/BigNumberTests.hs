import Test.QuickCheck
import BigNumber

prop_scanout :: Integer -> Bool
prop_scanout a = show a == BigNumber.output (scanner(show a))

-- Assuming Haskell devs know how to implement these operations...
prop_somaBN :: Integer -> Integer -> Bool
prop_somaBN a b = show (a + b) == BigNumber.output(somaBN (scanner (show a)) (scanner (show b)))

prop_subBN :: Integer -> Integer -> Bool
prop_subBN a b = show (a - b) == BigNumber.output(subBN (scanner (show a)) (scanner (show b)))

prop_mulBN :: Integer -> Integer -> Bool 
prop_mulBN a b = show (a*b) == BigNumber.output(mulBN (scanner (show a)) (scanner (show b)))

prop_divBN :: Integer -> Integer -> Bool 
prop_divBN a b 
    | a < 0 || b <= 0 = True 
    | otherwise = show (a `div` b) == BigNumber.output(fst foo) && show (a `mod` b) == BigNumber.output(snd foo)
    where foo = divBN (scanner (show a)) (scanner (show b))

main :: IO()
main = do
    putStrLn "> scanout"
    quickCheck (withMaxSuccess 50000 prop_scanout)
    putStrLn "> somaBN"
    quickCheck (withMaxSuccess 50000 prop_somaBN)
    putStrLn "> subBN"
    quickCheck (withMaxSuccess 50000 prop_subBN)
    putStrLn "> mulBN"
    quickCheck (withMaxSuccess 50000 prop_mulBN)
    putStrLn "> divBN"
    quickCheck (withMaxSuccess 50000 prop_divBN)