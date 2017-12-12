require 'prime'

RANGE_MIN = 2
RANGE_MAX = 2**7

class RSA
	def haveCommonDividors(arg1, arg2)
		(2..arg1).each do |num|
			return true if arg1 % num == 0 and arg2 % num == 0 
		end
		return false
	end

	def generatePrime
		Prime.take(rand(RANGE_MIN..RANGE_MAX)).reverse[0]
	end
	
#-----------------------------------
	@nConst = nil
	@eConst = nil
	@dConst = nil

	def initialize n, e, d
		@nConst = n
		@eConst = e
		@dConst = d
	end

	def n
		@nConst
	end

	def e
		@eConst
	end
	
	def d
		@dConst
	end

	def new_key
		p = generatePrime
		q = generatePrime

		while q == p
			q = generatePrime
		end

		n = p*q

		fn = (p-1)*(q-1)	
		e = rand(1..fn)

		while haveCommonDividors(e, fn) == true
			e = rand(1..fn)
		end		

		for d in 1..fn
			if((d*e)-1)%fn == 0
				break
			end
		end
	
		#@nConst = n
		#@eConst = e
		#@dConst = d

		rValue = Array.new
		rValue << n
		rValue << e
		rValue << d
		rValue

	end

	def encrypt message
		new = String.new
		message.each_char do |ch|
			o = ((ch.ord)**e)%n
			new << o.to_s
			new << "," if ch != message[-1]
		end
		new
	end

	def decrypt message
		new = String.new
		message.split(',').each do |ch|
			o = ((ch.to_i)**d)%n
			new << o
		end
		new
	end
end
