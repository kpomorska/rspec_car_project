require 'car'
require 'shared_examples/a_standard_vehicle'

describe Car do

	it_behaves_like('a standard vehicle')

	it "allows reading and writing for :doors" do
		subject.doors = 4
		expect(subject.doors).to eq 4
	end

	describe '#initialize' do
		it "deafults to 4 doors" do
			expect(subject.doors).to eq 4
		end

		it "custom number of doors" do
			car = Car.new(doors: 2)
			expect(car.doors).to eq 2
		end

		it "defaults to 4 if option is neither 2 or 4" do
			doors_counts = []
			[1,3,5,7].each do |n|
				car = Car.new(doors: n)
				doors_counts << car.doors
			end
			expect(doors_counts).to all ( eq(4) )
		end
	end

	describe '.colors' do

		let(:colors) { ['blue', 'black', 'red', 'green'] }

		it 'returns an array of color names' do
			expect(Car.colors).to match_array(colors)
		end
	end

	describe '#full_name' do

		let(:honda) { Car.new(make: 'Honda', year: 2007, color: 'blue') }
		let(:new_car) { Car.new }
		
		it 'returns a full name of object' do
			expect(honda.full_name).to eq("2007 Honda (blue)")
		end

		context 'when initialized with no arguments' do
			it 'returns a default full name' do
				expect(new_car.full_name).to eq("2007 Volvo (unknown)")
			end
		end
	end

	describe "#coupe?" do
		it "returns true if it has 2 doors" do
			subject.doors = 2
			expect(subject.coupe?).to be true
		end

		it "returns false if it has 4 doors" do
			subject.doors = 4
			expect(subject.coupe?).to be false
		end
	end

	describe "#sedan?" do
		it "returns true if it has 4 doors" do
			subject.doors = 4
			expect(subject.sedan?).to be true
		end

		it "returns false if it has 2 doors" do
			subject.doors = 2
			expect(subject.sedan?).to be false
		end
	end
	
end