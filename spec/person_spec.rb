require './lib/person.rb'

describe Person do
    
    subject { described_class.new(name: 'Mathias') }
    
    it 'is expected to have a :name on initialize' do
        expect(subject.name).not_to be nil
        expect(subject.name).to eq :name => 'Mathias'
    end
    
    it 'is expected to raise an error if no name is set' do
        expect { described_class.new }.to raise_error 'A name is required'
    end

    it 'is expected to have a :cash attribute with the value of 0 on initialize' do
        expect(subject.cash).to eq 0
    end

    it 'is expected to have a :account attribute' do
        expect(subject.account).to be nil
    end

    describe 'can create an Account' do
        # As a Person,
        # to be able to use banking services to manage my funds,
        # I would like to be able to create a bank account
        before { subject.create_account }

        it 'is expected to be an instance of Account class' do
            expect(subject.account).to be_an_instance_of Account
        end

        it 'is expected to have an account with himself as an owner' do
            expect(subject.account.owner).to be subject.name
        end

    end

    describe 'can manage funds if an account has been created' do
        let(:atm) { instance_double('Atm', funds: 1000) }
        # As a Person with a bank account,
        # in order to be able to put my funds in the account,
        # I would like to be able to make a deposit
        before { subject.create_account }

        it 'is expected to be able to deposit funds' do
            expect(subject.account.balance).to eq 0
            expect(subject.deposit(100)).to be_truthy
            expect(subject.account.balance).to eq 100
        end

        it 'is expected to add funds to the account balance - deducted from cash' do
            subject.cash = 100
            expect(subject.cash).to eq 100
            subject.deposit(100)
            expect(subject.account.balance).to eq 100
            expect(subject.cash).to eq 0

        end


    end

    describe 'can not manage funds if no account has been created' do
        # As a Person without a bank account,
        # In order to prevent me from using the wrong bank account,
        # It should NOT be able to make a deposit.
        
        it 'is expected to NOT being able to deposit funds' do
            expect { subject.deposit(100) }.to raise_error(RuntimeError, 'No account present')    
        end

    end
    
end
