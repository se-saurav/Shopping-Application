module Common where
import IO
import Utility

dispall::IO()
dispall=do
		--To display details of all the products firstly we need to fetch data from file
		p <- readFile "db.txt"
		--Now we will convert read data from IO String to Database
		convert <- condb p
		printall convert

printall::Database->IO()
printall []=putStrLn "\n\t\t\tAll product data displayed.\n"
printall ((a,b,c,d):xs)=do
			putStrLn ("\n\t\t\tProduct Code: " ++ a ++ "\tProduct Name: "++ b ++ "\tProduct Price: "++ (show c) ++ "\tProduct Quantity: "++(show d)++"\n")
			--Display all list data using printall
			printall xs

checkquantity::IO()
checkquantity=do
			putStrLn "\n\n\t\t\tEnter product code to find: \n\n"
			--We will get product code to search for the item in database
			i <- getLine
			--Read database
			p <- readFile "db.txt"
			convert <- condb p
			--Fetch the matching tuple
			let det=head [(a,b,c,d)|(a,b,c,d) <- convert, a==i]
			showquantity det
			putStrLn "\t\t\t"

showquantity::(Pcode, Pname, Price, Quantity)->IO()
showquantity (a,b,c,d)=putStrLn ("\n\t\t\tAvailable Product Quantity for Product "++ a ++" = "++(show d)++"\n")
