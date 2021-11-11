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

    def withdraw(amount, pin_code, account, atm)
        @account.balance -= amount
        @cash += amount
    end

    private

    def missing_name
        raise 'A name is required'
    end

    def missing_account
        raise 'No account present'
    end

    def deposit_amount(amount)
        @account.balance += amount
        @cash -= amount
    end

end