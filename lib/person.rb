require './account.rb'

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
        else
            withdraw_amount(args)
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

    def withdraw_amount(args)
        if args[:atm].funds < args[:amount]
            raise 'Insufficient funds in ATM'
        else
            @account.balance -= args[:amount]
            @cash += args[:amount]
        end
    end

end