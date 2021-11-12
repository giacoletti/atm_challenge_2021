require "./lib/atm.rb"

describe Atm do
  subject { Atm.new }

  let(:account) { instance_double("Account", pin_code: "1234", exp_date: "04/50", account_status: :active) }

  before do
    # before each test we need to add an attribute of 'balance'
    # to the 'account' object and set the value to '100'
    allow(account).to receive(:balance).and_return(100)

    # we also need to allow the fake 'account' to receive new
    # balance using a setter method 'balance='
    allow(account).to receive(:balance=)
  end

  it "is expected to hold $1000 when instantiated" do
    expect(subject.funds).to eq 1000
  end

  it "is expected to reduce funds on withdraw from 1000 to 950" do
    expect { subject.withdraw 50, "1234", account }
      .to change { subject.funds }.from(1000).to(950)
  end

  it "is expected to allow withdrawal if account has enough balance" do
    # We need to tell the spec what to look for as the responce
    # And store that in a variable called 'expected_outcome'.
    # Please note that we are omitting the 'bills'part at the moment,
    # We will modify this test and add that later.

    expected_output = {
      status: true,
      message: "success",
      date: Date.today,
      amount: 45,
      bills: [20, 20, 5],
    }

    # We need to pass in two arguments to the 'withdraw' mwthiod.
    # The ammount of money we want to withdraw AND the 'account' object.
    # The reason we pass in the 'account' object is that the Atm needs
    # to be able to access information about the 'accounts' balance
    # in order to be able to clear the transaction.
    expect(subject.withdraw(45, "1234", account)).to eq expected_output
  end

  # sad path
  it "is expected to reject a withdrawal if account has insufficient funds" do
    expected_output = {
      status: false,
      message: "insufficient funds",
      date: Date.today,
    }
    # trying to withdraw 105 from my account that has only 100
    expect(subject.withdraw(105, "1234", account)).to eq expected_output
  end

  it "is expected to reject withdraw if ATM has insufficient funds" do
    # to prepare the test we want to decrease the funds value
    # to a lower value than the original 1000
    subject.funds = 50
    expected_output = {
      status: false,
      message: "insufficient funds in ATM",
      date: Date.today,
    }
    expect(subject.withdraw(100, "1234", account)).to eq expected_output
  end

  it "is expected to reject withdraw if the pin is wrong" do
    expected_output = {
      status: false,
      message: "wrong pin",
      date: Date.today,
    }
    expect(subject.withdraw(50, 9999, account)).to eq expected_output
  end

  it "is expected to reject withdraw if the card is expired" do
    allow(account).to receive(:exp_date).and_return("12/15")
    expected_output = {
      status: false,
      message: "card expired",
      date: Date.today,
    }
    expect(subject.withdraw(6, "1234", account)).to eq expected_output
  end

  it "is expected to reject if account is disabled" do
    allow(account).to receive(:account_status).and_return(:deactivated)
    expected_output = {
      status: false,
      message: "account disabled",
      date: Date.today,
    }
    expect(subject.withdraw(6, "1234", account)).to eq expected_output
  end

  it "is expected to reject if amount is not divisible by 5" do
    expected_output = {
      status: false,
      message: "Denominator not available",
      date: Date.today,
    }
    expect(subject.withdraw(6, "1234", account)).to eq expected_output
  end
end
