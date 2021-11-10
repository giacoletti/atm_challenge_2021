require './lib/account.rb'

describe Account do
    subject { Account.new }
    
    let(:person) { instance_double('Person', name: 'Giovanni') }
    subject { described_class.new({owner: person}) }

    it 'is expected to have 4 digits for pin_code' do
        number = subject.pin_code
        number_length = Math.log10(number).to_i + 1
        expect(number_length).to eq 4
    end

    it 'is expected to have a expiry date on initialize' do
        # Here we set the validity of the card to 5 yrs as default
        expected_date = Date.today.next_year(5).strftime("%m/%y")
        expect(subject.exp_date).to eq expected_date
    end

    it 'is expected to have :active status on initialize' do
        expect(subject.account_status).to eq :active
    end

    it 'is expected to deactivate account using the class method' do
        subject.deactivate
        expect(subject.account_status).to eq :deactivated
    end

    it 'is expected to have an owner' do
        expect(subject.owner).to eq person
    end

    it 'is expected to raise error if no owner is set'do
        expect { described_class.new }.to raise_error 'An Account owner is required'
    end
   
end
