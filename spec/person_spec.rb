require "./lib/person.rb"
require "./lib/atm.rb"

describe Person do
  subject { described_class.new(name: "Mathias") }

  it "is expected to have a :name on initialize" do
    expect(subject.name).not_to be nil
    expect(subject.name).to eq "Mathias"
  end

  it "is expected to raise an error if no name is set" do
    expect { described_class.new }.to raise_error "A name is required"
  end

  it "is expected to have a :cash attribute with the value of 0 on initialize" do
    expect(subject.cash).to eq 0
  end

  it "is expected to have a :account attribute" do
    expect(subject.account).to be nil
  end

  describe "can create an Account" do
    # As a Person,
    # to be able to use banking services to manage my funds,
    # I would like to be able to create a bank account
    before { subject.create_account }

    it "is expected to be an instance of Account class" do
      expect(subject.account).to be_an_instance_of Account
    end

    it "is expected to have an account with himself as an owner" do
      expect(subject.account.owner).to be subject.name
    end
  end

  describe "can manage funds if an account has been created" do
    let(:atm) { Atm.new }
    # As a Person with a bank account,
    # in order to be able to put my funds in the account,
    # I would like to be able to make a deposit
    before { subject.create_account }

    it "is expected to be able to deposit funds" do
      expect(subject.account.balance).to eq 0
      expect(subject.deposit(100)).to be_truthy
      expect(subject.account.balance).to eq 100
    end

    it "is expected to add funds to the account balance - deducted from cash" do
      # As a person depositing cash is suposed to have the cash availible
      # The bank account is suposed to obtain that money on the balance
      # and at the same time, be removed from the person's access to cash
      subject.cash = 100
      expect(subject.cash).to eq 100
      subject.deposit(100)
      expect(subject.account.balance).to eq 100
      expect(subject.cash).to eq 0
    end

    it "is expected to be able to withdraw funds" do
      subject.account.balance = 500
      command = lambda { subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm) }
      expect(command.call).to be_truthy
    end

    it "is expected to raise an error if no ATM is passed in to the withdraw method" do
      command = lambda { subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account) }
      expect { command.call }.to raise_error "An ATM is required"
    end

    describe "can add funds to cash and deduct from the account balance on withdraw" do
      before do
        subject.cash = 100
        subject.deposit(100)
      end

      it "is expected to have the account balance of 100 after deposit of 100" do
        expect(subject.account.balance).to eq 100
      end

      it "is expected to have cash value of 0 after deposit of 100" do
        expect(subject.cash).to eq 0
      end

      it "is expected to have account balance of 0 after withdrawal of 100" do
        subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm)
        expect(subject.account.balance).to eq 0
      end

      it "is expected to have cash value of 100 after withdrawal of 100" do
        subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm)
        expect(subject.cash).to eq 100
      end
    end

    it "is expected to raise an error if trying to withdraw without available funds in ATM" do
      atm.funds = 5
      command = lambda { subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm) }
      expect { command.call }.to raise_error "Insufficient funds in ATM"
    end

    it "is expected to raise an error if no pin code is passed to the withdraw method" do
      command = lambda { subject.withdraw(amount: 100, account: subject.account, atm: atm) }
      expect { command.call }.to raise_error "Pin code is required"
    end

    it "is expected to raise an error if account balance is insufficient" do
      command = lambda { subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm) }
      expect { command.call }.to raise_error "Insufficient account balance"
    end
  end

  describe "can not manage funds if no account has been created" do
    # As a Person without a bank account,
    # In order to prevent me from using the wrong bank account,
    # It should NOT be able to make a deposit.

    it "is expected to NOT being able to deposit funds" do
      expect { subject.deposit(100) }.to raise_error(RuntimeError, "No account present")
    end
  end
end
