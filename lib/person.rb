require './lib/account.rb'

class Person
    
    attr_accessor :name, :cash, :account
    
    def initialize(args = {})
        @name = set_name(args[:name])
        @cash = 0
    end

    def create_account
        @account = Account.new({owner: self.name})
    end

    def deposit(amount)
        @account == nil ? missing_account : deposit_amount(amount)
    end

    def withdraw(args = {}) # amount, pin_code, account, atm
        if atm_missing?(args[:atm])
            missing_atm
        elsif account_missing?(args[:account])
            missing_account
        elsif pin_code_missing?(args[:pin])
            missing_pin_code
        elsif insufficient_funds_in_atm?(args[:atm], args[:amount])
            insufficient_funds
        elsif insufficient_balance?(@account.balance, args[:amount])
            insufficient_account_balance
        else
            response = args[:atm].withdraw(args[:amount], args[:pin], args[:account])
            response[:status] == true ? add_cash(args[:amount]) : response
        end
    end

    private

    def missing_name
        raise 'A name is required'
    end

    def missing_account
        raise 'No account present'
    end

    def missing_atm
        raise 'An ATM is required'
    end

    def missing_pin_code
        raise 'Pin code is required'
    end

    def insufficient_funds
        raise 'Insufficient funds in ATM'
    end

    def insufficient_account_balance
        raise 'Insufficient account balance'
    end

    def set_name(name)
        name == nil ? missing_name : name
    end

    def deposit_amount(amount)
        @account.balance += amount
        @cash -= amount
    end

    def atm_missing?(atm)
        atm == nil
    end

    def account_missing?(account)
        account == nil
    end

    def pin_code_missing?(pin_code)
        pin_code == nil
    end

    def insufficient_funds_in_atm?(atm, amount)
        atm.funds < amount
    end

    def insufficient_balance?(balance, amount)
        balance < amount
    end

    def add_cash(amount)
        @cash += amount
    end

end