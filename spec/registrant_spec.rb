require 'spec_helper'

RSpec.describe Registrant do
    before (:each) do
        @registrant_1 = Registrant.new('Bruce', 18, true)
        @registrant_2 = Registrant.new('Penny', 15 )
    end

    it 'can initialize' do
            expect(@registrant_1).to be_a(Registrant)
            expect(@registrant_1.name).to eq('Bruce')
            expect(@registrant_1.age).to be(18)
            expect(@registrant_1.permit?).to eq(true)
    end

    it "defaults to initializing without a permit" do
       expect(@registrant_2.permit?).to eq(false)
    end

    it "starts without any license data" do
       expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it "can earn a permit if have passed the written test and is over 16" do
        @registrant_2.earn_permit
        expect(@registrant_2.permit?).to eq(true)
    end

    #write a test for the helper method permit?
end
