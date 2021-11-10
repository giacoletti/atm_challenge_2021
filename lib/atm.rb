require 'date'
class Atm
    attr_accessor :funds
    def initialize
        @funds = 1000
    end

    # note that we will also change 'value' to 'amount'
    # it is a better name for our domain
    def withdraw(amount, pin_code, account)
        # We will be using Ruby's 
        # `case` - `when` - `then` flow control statement
        # and check if there is enough funds in the account
        case
        when insufficient_funds_in_account?(amount, account)
            # we exit the method if the amount we want to withdraw
            # is bigger than the balance on the account
            {
                status: false,
                message: 'insufficient funds',
                date: Date.today
            }
        when insufficient_funds_in_atm?(amount)
            {
                status: false,
                message: 'insufficient funds in ATM',
                date: Date.today
            }
        when incorrect_pin?(pin_code, account.pin_code)
            { status: false, message: 'wrong pin', date: Date.today }

        when card_expired?(account.exp_date)
            { status: false, message: 'card expired', date: Date.today }
            
        when account_deactivated?(account.account_status)
            { status: false, message: 'account disabled', date: Date.today }

        else
            # if it's not, we preform the transaction
            perform_transaction(amount,account)
        end
    end

    private 

    def insufficient_funds_in_account?(amount, account)
        amount > account.balance
    end

    def insufficient_funds_in_atm?(amount)
        @funds < amount
    end

    def perform_transaction(amount, account)
        # We DEDUCT the amount from the Atm's funds
        @funds -= amount
        # We also DEDUCT the amount from the accounts balance
        account.balance = account.balance - amount
        # and we return a responce for a successfull withdraw.
        {
            status: true,
            message: 'success',
            date: Date.today,
            amount: amount,
            bills: add_bills(amount) 
        }
    end

    def incorrect_pin?(pin_code, actual_pin)
        pin_code != actual_pin
    end

    def card_expired?(exp_date)
        Date.strptime(exp_date, '%m/%y') < Date.today
    end

    def account_deactivated?(account_status)
        account_status == :deactivated
    end

    def add_bills(amount)
        denominations = [20, 10, 5]
        bills = []
        denominations.each do |bill|
            while amount - bill >= 0
                amount -= bill
                bills << bill
            end
        end
        bills
    end

end
