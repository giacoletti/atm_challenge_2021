require 'account.rb'

class Person
    
    attr_accessor :name, :cash, :account
    
    def initialize(name = '')
        name == '' ? missing_name : @name = name
        @cash = 0
    end

    def create_account
        @account = Account.new({owner: @name})
    end

    def deposit(amount)
        @account == nil ? missing_account : deposit_amount(amount)
    end

    def withdraw(args = {}) # amount, pin_code, account, atm
        args[:atm] == nil ? missing_atm : witdraw_amount(args)
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

    def deposit_amount(amount)
        @account.balance += amount
        @cash -= amount
    end

    def witdraw_amount(args)
        if args[:atm].funds < args[:amount]
            raise 'Insufficient funds in ATM'
        else
            @account.balance -= args[:amount]
            @cash += args[:amount]
        end
    end

end