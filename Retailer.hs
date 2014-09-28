module Retailer where
import IO
import Utility
import Common

retlogin::IO()
retlogin=do
		--getting user id of the customer
		putStrLn "Enter your ID: "
		id <- getLine
		validate id
		putStrLn "Enter your password: "
		--getting password of the customer
		pass <- getLine
		validate pass
		--rading customer details file
		p <- readFile "retdata.txt"
		convert <- conret p
		--Fetch matching tuple for id and pass
		let det=head [(a,b,c)|(a,b,c) <- convert, b==id, c==pass]
		greetret det

greetret::(String, String, String)->IO()
greetret (a, b, c)= do
			putStrLn ("Welcome "++ a ++ "\n")
			showretmenu

retreg::IO()
retreg=do
		--Asking user for details
		putStrLn "Enter your Name: "
		name <- getLine
		putStrLn "Enter your ID: "
		id <- getLine
		putStrLn "Enter your password: "
		pass <- getLine
		putStrLn "Re-enter your password: "
		repass <- getLine
		--Read file to get database
		p <- readFile "retdata.txt"
		convert <- conret p
		let ls=convert ++ [(name,id,pass)]
		--update file
		writeFile "retdata.txt" (show ls)
		putStrLn ("Welcome "++ name ++ "\n")
		showretmenu

--Verify, product code must start with P
verify::(String, String, Float, Int)->Bool
verify (x, y,z,c)=head x=='P'

addprod::IO()
addprod=do
		--get product details
		putStrLn "\nEnter product code: "
		code <- getLine
		putStrLn "\nEnter product name: "
		name <- getLine
		putStrLn "\nEnter product price: "
		price <- getLine
		putStrLn "\nEnter product quantity: "
		quan <- getLine
		let pr=read price ::Float
		let qn=read quan ::Int
		add verify [(code, name, pr, qn)]

--add is a higher order function, used to add records to database
add::((String, String, Float, Int)->Bool)->[(String, String, Float, Int)]->IO()
add ver xs=do
		if ver (head xs) then
				do
					p <- readFile "db.txt"
					convert <- condb p
					let ls=convert ++ xs
					writeFile "db.txt" (show ls)
					putStrLn "\nEntry added successfully."
		else putStrLn "Error adding data. Product code must start with P."

showretmenu::IO()
showretmenu=do
		--display menu options
		putStrLn "Select Option"
		putStrLn "1. Add new product"
		putStrLn "2. Display all product"
		putStrLn "3. Check quantity"
		putStrLn "4. Exit"
		--get selection input
		x<-getChar
		--call selected function
		case x of
			'1'->do
				putStrLn "\nAdd new item to database"
				addprod
				showretmenu
			'2'->do
				putStrLn "\nDisplay all products present"
				dispall
				showretmenu
			'3'->do
				putStr "\nCheck quantity of a product"
				checkquantity
				showretmenu
			otherwise->putStrLn "\nExiting"