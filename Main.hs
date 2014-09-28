module Main where
import Utility
import IO
import Customer
import Retailer

main=do
	--Display formatted screen
	putStrLn "\t\t\t||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
	putStrLn "\t\t\t||||\t\t\t\tRETAIL MANAGEMENT SYSTEM\t\t\t||||\n"
	putStrLn "\t\t\t||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
	putStrLn "\t\t\tWelcome user\n\n"
	putStrLn "\t\t\tPlease select your authentication type:\n"
	putStrLn "\t\t\t1. Customer\n\t\t\t2. Retailer\n\t\t\t3. Register Customer\n\t\t\t4. Register Retailer\n\nEnter->"
	x <- getChar
	--Display menu options
	case x of
		'1'->do
			putStrLn "\nCustomer login..."
			custlogin
		'2'->do
			putStrLn "\nRetailer login..."
			retlogin
		'3'->do
			putStrLn "\nCustomer registration..."
			custreg
		'4'->do
			putStrLn "\nRetailer registration..."
			retreg
		otherwise->putStrLn "Exiting"