# atm_challenge_2021
#### project by Giovanni Lacoletti & Mathias Ljungholm

## The Code
 The ATM_challenge code is a test where we create the logical respons and actions that an ATM machine would preform. We create test cases for various conditions that could happen in reality and design the ATM responce accordingly. We are only operating on the "Logical Tier" for this project, meaning that we will not produce a UI or store the data, we will soley be working with the logic using ruby. 

## Dependencies
 Gems framework we used are 'rspec' for unit test

## Setup
The repo contains the Gemfile, so you only need to install the bundle.

In CLI type the command: bundle install

This will install the dependencies that is required to run the test.

Inside ".rspec" file make sure you have the flaggs: 
	--format documentation
	--require spec_helper
	--color

## Instructions

 The code does not have a user interface, so the way you need to run the code and test
 open the console and enter irb 
 " require'./lib/person.rb' " and " require'./lib/atm.rb' " and " require'./lib/account.rb' " in order to access the code in IRB.
 
 now you can create a person following the syntax: 
 
> person = Person.new ({name: "Mathias"})
> => #<Person:0x0000563980776e28 @name="Mathias", @cash=0> 
> person.create_account
> => #<Account:0x000056398076a768 @pin_code=8948, @exp_date="11/26", @account_status=:active, @balance=0, @owner="Mathias"> 
> person.deposit(5000)
> => -5000 
> person.account
> => #<Account:0x000056398076a768 @pin_code=8948, @exp_date="11/26", @account_status=:active, @balance=5000, @owner="Mathias"> 

 This is a simple example of us instantiating a person "Mathias", and that person creating an account, and depositing 5000.
 those 5000 will show up in the list of attributes once you type person.account.


## Acknowledgments

## Updates/Improvment plans

The code, at this stage, does not take into account the fact that either the balance of the account or the person using the ATM can end up with negative money. witch is obviously nonsence. 
In later updates we will need to make sure that this is not the case. 

Currently you, as a person, can deposit 200 and the account will display that you have increased your account with 200, while as a person you have -200. This does not reflect real life at all, and will have to be fixed.

the same goes for the account. it will display a negative amount (witch I supose could happen if it is a credit account) but it makes more sence to add a restriction, that the account can not reach <0 unless otherwiese stated. 

Furthermore you have the ability to deactivate your account, but this doesn't, at the moment, stop you from depositing funds.

This will have to be implemented at a later stage.

## License

