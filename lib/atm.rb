class Atm
    attr_accessor :funds

    def initialize
        @funds = 1000
    end

    def withdraw(value)
        @funds -= value
    end
end
