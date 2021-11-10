require 'date'
class Account
    STANDARD_VALIDITY_YRS = 5
    attr_accessor :pin_code, :account_status, :exp_date, :account_owner, :balance
    def initialize
        @pin_code = generate_pin()
        @exp_date = set_expire_date()
        @account_status = :active
        
    end

    def deactivate
        @account_status = :deactivated
    end

    private

    def generate_pin
        rand(1000..9999)
    end

    def set_expire_date
        Date.today.next_year(Account::STANDARD_VALIDITY_YRS).strftime('%m/%y')
    end
    

end

