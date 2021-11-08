require './lib/atm.rb'

describe Atm do
    subject { Atm.new } 
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
end
