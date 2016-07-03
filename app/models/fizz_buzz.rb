class FizzBuzz
	include ActiveModel::Validations

	validate :biggest_number_allowed, :params_are_numbers, :params_are_allowed

	attr_accessor :per_page, :offset

	def initialize(params)
		@per_page = params[:per_page]
		@offset = params[:offset]
	end

	BIGGEST_ALLOWED_NUMBER = 100000000000
	ALLOWED_PER_PAGE_VALUES = [50, 100, 200]
	ALLOWED_OFFSET_VALUES = (1..(BIGGEST_ALLOWED_NUMBER / ALLOWED_PER_PAGE_VALUES[0]))

	def biggest_number_allowed
		if per_page.to_i * (offset ? offset.to_i + 1 : 0) > BIGGEST_ALLOWED_NUMBER
			errors.add(:base, "The application cannot show numbers bigger than #{BIGGEST_ALLOWED_NUMBER}!")
		end
	end

	def params_are_numbers
		unless (per_page != '0' && per_page.to_i != 0) && (offset && offset != '0' ? offset.to_i != 0 : true)
			errors.add(:base, 'Query parameters must be numbers.')
		end
	end

	def params_are_allowed
		unless ALLOWED_PER_PAGE_VALUES.include? per_page.to_i
			errors.add(:base, "Per page parameters should be #{ALLOWED_PER_PAGE_VALUES.join(' or ')}." )
		end
	end

	def numbers
		if offset
			range_start = (offset.to_i * per_page.to_i) + 1
			range_end = range_start + per_page.to_i
			values((range_start..range_end))
		else
			values((1..per_page.to_i))
		end
	end

	private

	def values(numbers)
		numbers.map do |n|
			if n % 3 == 0 && n % 5 == 0
				'FizzBuzz'
			elsif n % 3 == 0
				'Fizz'
			elsif n % 5 == 0
				'Buzz'
			else
				n
			end
		end
	end
end