describe 'Doubles' do 

	it 'allows stubbing methods' do
		dbl = double("Chant")
		allow(dbl).to receive(:hey!)
		expect(dbl).to respond_to(:hey!)	
	end

	it "allows stubbing a response with block" do
		dbl = double("Chant")
		allow(dbl).to receive(:hey!) { "Ho!" }

		expect(dbl.hey!).to eq("Ho!")
	end

	it "allows stubbing a response with #and_return" do
		dbl = double("Chant")
		allow(dbl).to receive(:hey!).and_return("Ho!")

		expect(dbl.hey!).to eq("Ho!")
	end

	context 'with partial test doubles' do

		it 'allows stubbing inctance methods on Ruby classes' do
			time = Time.new(2010, 1, 1, 12, 0, 0)
			allow(time).to receive(:year).and_return(1975)

			expect(time.to_s).to eq('2010-01-01 12:00:00 +0000')
			expect(time.year).to eq(1975)
		end

		it 'allows stubbing instance methods on custom classes' do
			class SuperHero
				attr_accessor :name
			end

			hero = SuperHero.new
			hero.name = 'Superman'
			expect(hero.name).to eq('Superman')

			allow(hero).to receive(:name).and_return('Clark Kent')

			expect(hero.name).to eq('Clark Kent')
		end

		it 'allows stubbing class methods on Ruby classes' do
			fixed = Time.new(2010, 1, 1, 12, 0, 0)
			allow(Time).to receive(:now).and_return(fixed)

			expect(Time.now).to be(fixed)
		end

		it 'allows stubbing database calls a mock obj' do
			class Customer
				attr_accessor :name
				def self.find
					# database lookup, return obj
				end
			end

			dbl = double('Mock Customer')
			allow(dbl).to receive(:name).and_return('Bob')
			allow(Customer).to receive(:find).and_return(dbl)

			customer = Customer.find
			expect(customer.name).to eq('Bob')
		end

	end

	context 'with message expectations' do
		it "expects a call and allows a response" do
			dbl = double("Chant")
			expect(dbl).to receive(:hey!).and_return("Ho!")

			dbl.hey!
		end
	end

	context 'with argument constraints' do
		it "expects agruments will macth" do
			dbl = double("Customer List")
			expect(dbl).to receive(:sort).with(any_args).and_return('qwerty')

			expect(dbl.sort('country', 123)).to eq('qwerty')
		end
	end

	context 'with spying abilities' do
    
    it "can expect a call after it is received" do
      dbl = spy("Chant")
      allow(dbl).to receive(:hey!).and_return("Ho!")
      dbl.hey!
      expect(dbl).to have_received(:hey!)
    end

    it "can use message constraints" do
      dbl = spy("Chant")
      allow(dbl).to receive(:hey!).and_return("Ho!")
      dbl.hey!
      dbl.hey!
      dbl.hey!
      expect(dbl).to have_received(:hey!).with(no_args).exactly(3).times
    end
    
    it "can expect any message already sent to a declared spy" do
      customer = spy("Customer")
      # Notice that we don't stub :send_invoice
      # allow(customer).to receive(:send_invoice)
      customer.send_invoice
      expect(customer).to have_received(:send_invoice)
    end
    
    it "can expect only allowed messages on partial doubles" do
      class Customer
        def send_invoice
          true
        end
      end
      customer = Customer.new
      # Must stub :send_invoice to start spying
      allow(customer).to receive(:send_invoice)
      customer.send_invoice
      expect(customer).to have_received(:send_invoice)
    end
    
    context 'using let and a before hook' do
      let(:order) do
        spy('Order', :process_line_items => nil, 
                     :charge_credit_card => true, 
                     :send_confirmation_email => true)
      end
      
      before(:example) do
        order.process_line_items
        order.charge_credit_card
        order.send_confirmation_email
      end
      
      it 'calls #process_line_items on the order' do
        expect(order).to have_received(:send_confirmation_email)
        expect(order).to have_received(:charge_credit_card)
        expect(order).to have_received(:process_line_items)
      end
      it 'calls #charge_credit_card on the order' do
        expect(order).to have_received(:charge_credit_card)
      end
      it 'calls #send_confirmation_email on the order' do
        expect(order).to have_received(:send_confirmation_email)
      end
    end
    
  end
end