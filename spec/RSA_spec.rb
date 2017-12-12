require_relative '../lib/RSA.rb'

describe RSA do
	describe 'Basic Functions' do
		rsa = RSA.new(1,2,3)
		context "call n" do
			it "returns 1" do
				expect(rsa.n).to eq 1	
			end
		end
		context "call e" do
			it "returns 2" do
				expect(rsa.e).to eq 2
			end
		end
		context "call d" do
			it "returns 3" do
				expect(rsa.d).to eq 3
			end
		end

		context "call new_key" do
			it "returns array with 3 values" do
				arr= rsa.new_key
				expect(arr.length).to eq 3
			end		
		end
	end

	describe "Encrypt&Decrypt 1 word" do
		rsa = RSA.new(0,0,0)
		arr = rsa.new_key
		rsa = RSA.new(arr[0], arr[1], arr[2]);
		msg = "Te st"

		context "Given text message" do
			it "Encrypts it to something other" do
				expect(rsa.encrypt(msg)).not_to eq msg
			end

			it "Decrypts correctly" do
				crypt = rsa.encrypt(msg)
				expect(rsa.decrypt(crypt)).to eq msg
			end
		end
	end
end
