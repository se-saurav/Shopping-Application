module Customer where
import IO
import Utility
import Common

custlogin::IO()
custlogin=do
		--getting user id of the customer
		putStrLn "\t\t\tEnter your ID: "
		id <- getLine
		validate id
		putStrLn "\t\t\tEnter your password: "
		--getting password of the customer
		pass <- getLine
		validate pass
		--rading customer details file
		p <- readFile "custdata.txt"
		convert <- concust p
		--Fetch matching tuple for id and pass
		let det=head [(a,b,c)|(a,b,c) <- convert, b==id, c==pass]
		greetcust det

greetcust::(String, String, String)->IO()
greetcust (a, b, c)= do
			putStrLn ("\t\t\tWelcome "++ a++"\n")
			showcustmenu

custreg::IO()
custreg=do
		--Asking user for details
		putStrLn "\t\t\tEnter your Name: "
		name <- getLine
		putStrLn "\t\t\tEnter your ID: "
		id <- getLine
		putStrLn "\t\t\tEnter your password: "
		pass <- getLine
		putStrLn "\t\t\tRe-enter your password: "
		repass <- getLine
		--Read file to get database
		p <- readFile "custdata.txt"
		convert <- concust p
		let ls=convert ++ [(name,id,pass)]
		--update file
		writeFile "custdata.txt" (show ls)
		putStrLn ("\t\t\tWelcome "++ name++"\n")
		showcustmenu

buyprod=do
		--Display product list
		dispall
		putStrLn "\t\t\tSelect product code you want to buy."
		--get product code from customer
		code <- getLine
		putStrLn "\t\t\tEnter the quanity for buying."
		--get quantity of product to buy
		quan <- getLine
		--parsing String quantity to Float
		let iquan=read quan ::Int
		let nquan=read quan ::Float
		p <- readFile "db.txt"
		convert <- condb p
		--get product attributes
		let qn=head [(d)|(a,b,c,d) <- convert, a==code]
		let pr=head [(c)|(a,b,c,d) <- convert, a==code]
		let name=head [(b)|(a,b,c,d) <- convert, a==code]
		let newdata=[(a, b,c, d-iquan)|(a,b,c,d) <- convert, a==code]
		let nnewdata=[(a, b, c, d)|(a,b,c,d) <- convert, a /= code]
		let nnnewdata=newdata++nnewdata
		writeFile "db.txt" (show nnnewdata)
		let cost = (nquan*pr)
		putStrLn ("\n\n\t\t\tYOUR BILL\n\n\t\t\tProduct Name: "++name++"\n\t\t\t"++"Product Code: "++code++"\n\t\t\t"++"Product Quantity: "++(show nquan)++"\n\t\t\t"++"Product Price: "++(show pr)++"\n\t\t\t"++"Total cost: "++ (show cost) ++"\n")
		--Ask for more purchase
		putStrLn "Do you want to buy another product (y/n)."
		i <- getChar
		case i of
				'y'->do
					--call buyprod recursively
					buyprod
				otherwise->putStrLn "\nThank you for buying with us."	
		showcustmenu

showcustmenu::IO()
showcustmenu=do
		--display menu options
		putStrLn "\t\t\tSelect Option"
		putStrLn "\t\t\t1. Buy Products"
		putStrLn "\t\t\t2. Display all product"
		putStrLn "\t\t\t3. Check quantity"
		putStrLn "\t\t\t4. Exit"
		--get selection input
		x<-getChar
		--call selected function
		case x of
			'1'->do
				putStrLn "\t\t\tAdd new item to database"
				buyprod
				showcustmenu
			'2'->do
				putStrLn "\t\t\tDisplay all products present"
				dispall
				showcustmenu
			'3'->do
				putStr "\t\t\tCheck quantity of a product"
				checkquantity
				showcustmenu
			otherwise->putStrLn "\t\t\tExiting"