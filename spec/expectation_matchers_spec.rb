describe 'Expectation Matchers' do

  describe 'equivalence matchers' do

    it 'will match loose equality with #eq' do
      a = "2 cats"
      b = "2 cats"
      expect(a).to eq(b)
      expect(a).to be == b      # synonym for #eq

      c = 17
      d = 17.0
      expect(c).to eq(d)        # different types, but "close enough"
    end
    
    it 'will match value equality with #eql' do
      a = "2 cats"
      b = "2 cats"
      expect(a).to eql(b)       # just a little stricter

      c = 17
      d = 17.0
      expect(c).not_to eql(d)   # not the same, close doesn't count
    end

    it 'will match identity equality with #equal' do
      a = "2 cats"
      b = "2 cats"
      expect(a).not_to equal(b) # same value, but different object

      c = b
      expect(b).to equal(c)     # same object
      expect(b).to be(c)        # synonym for #equal
    end
    
  end

	describe 'truthiness matchers' do
		it 'will match true/false' do
			expect(1 < 2).to be true
			expect(1 > 2).to be false

			expect('foo').not_to be true
			expect(nil).not_to be false
			expect(0).not_to be false			
		end

		it 'will match truthy/falsey' do
			expect(1 < 2).to be_truthy
			expect(1 > 2).to be_falsey

			expect('foo').to be_truthy
			expect(nil).to be_falsey
			expect(0).not_to be_falsey			
		end

		it 'will match nil' do
			expect(nil).to be_nil
			expect(nil).to be nil

			expect(false).not_to be_nil
			expect(0).not_to be nil			
		end
	end

	describe 'numeric comparision matchers'

	describe 'collection matchers'

	describe 'prediate matchers' do
		it 'will match be_* to custom methods ending in ?'do
			expect(1).to be_odd
			expect(2).to be_even
			expect(0).to be_zero

			class Product
				def visible?; true; end
			end

			product = Product.new
			expect(product).to be_visible
		end
	
		it 'will match have_* to custom methods like has_*'do
			class Customer
				def has_pending_order?; true; end
			end
			customer = Customer.new

			expect(customer).to have_pending_order		
		end
	end

	describe 'observation matchers' do
		it 'change a value of an object' do
			x = 10
			expect{x += 1}.to change{x}.from(10).to(11)
			expect{x += 1}.to change{x % 2}.from(1).to(0)
		end
	end

	describe 'complex expectations' do
	end
end