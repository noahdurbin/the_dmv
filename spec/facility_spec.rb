require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])

      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')

      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register vehicle' do
     it 'can register a vehicle' do
        cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
        @facility_1.add_service('Vehicle Registration')
        expect(@facility_1.register_vehicle(cruz)).to eq([cruz])
     end
#test the sad path
     it 'can record the registration date' do
         cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
         @facility_1.add_service('Vehicle Registration')
         @facility_1.register_vehicle(cruz)
         expect(cruz.registration_date).to eq(Date.today)
     end

     it 'can determine correct plate type' do
         cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
         @facility_1.add_service('Vehicle Registration')
         @facility_1.register_vehicle(cruz)
         expect(cruz.plate_type).to eq(regular)
     end

     it 'can register multiple plate types' do
         camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
         @facility_1.add_service('Vehicle Registration')
         @facility_1.register_vehicle(camaro)
         expect(camaro.plate_type).to eq(antique)
     end

     it 'can charge registration fees' do
         cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
         @facility_1.add_service('Vehicle Registration')
         @facility_1.register_vehicle(cruz)
         expect(cruz.collected_fees).to eq(100)
     end

     it 'can charge different amounts for different plate types' do
         bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
         @facility_1.add_service('Vehicle Registration')
         @facility_1.register_vehicle(bolt)
         expect(@facility_1.collected_fees).to eq(300)
     end
  end
end
