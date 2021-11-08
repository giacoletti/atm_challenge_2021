require './lib/atm.rb'

describe Atm do
    subject { Atm.new } 

    let(:account) {instance_double('Account')}

    before do
        # before each test we need to add an attribute of 'balance'
        # to the 'account' object abd set the vakye ti '100'
        allow(account).to receive(:balance).and_return(100)

        # we also need to allow the fake 'account' to recieve new
        # balance using a setter method 'balance='
        allow(account).to receive(:balance=)
    end

    it 'is expected to hold $1000 when instantiated' do
        expect(subject.funds).to eq 1000
    end
    
    it 'is expected to reduce funds on withdraw' do
        subject.withdraw 50
        expect(subject.funds).to eq 950
    end
    
    it 'is expected to reduce withdraw' do
        expect { subject.withdraw 50 }
        .to change {subject.funds }.from(1000).to(950)
    end

    it 'is expected to allow withdrawal if account has enough balance' do
        # We need to tell the spec what to look for as the responce
        # And store that in a variable called 'expected_outcome'.
        # Please note that we are omitting the 'bills'part at the moment,
        # We will modify this test and add that later.

        expected_output = {
            status: true,
            message: 'success',
            date: Date.today,
            amount: 45
        }

        # We need to pass in two arguments to the 'withdraw' mwthiod.
        # The ammount of money we want to withdraw AND the 'account' object.
        # The reason we pass in the 'account' object is that the Atm needs
        # to be able to access information about the 'accounts' balance
        # in order to be able to clear the transaction.
        expect(subject.withdraw(45, account)).to eq expected_output
    end
end

