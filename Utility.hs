module Utility where
import IO
import System.Exit

--Data type declarations
type Pcode=String
type Pname=String
type Price=Float
type Quantity=Int
type Record=(Pcode, Pname, Price, Quantity)
type Database=[Record]

--Converter functions
concust:: String -> IO [(String, String, String)]
concust = readIO

conret:: String -> IO [(String, String, String)]
conret = readIO

condb:: String -> IO Database
condb = readIO

append :: [a] -> [a] -> [a]
append xs ys = foldr (:) ys xs

--function to validate input
validate :: String -> IO ()				
validate str = do
			if null str	
			then do
				putStrLn "\t\t\tRequired data was not entered. System will exit.\n\t\t\t"
				exitWith ExitSuccess
			else 
				return()