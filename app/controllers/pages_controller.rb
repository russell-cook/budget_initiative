class PagesController < ApplicationController
	http_basic_authenticate_with :name=> "admin", :password=> "ppbb"

	def list
		render
	end

	def ell
		render
	end

	def hunger
		render
	end

	def lakes_crossing
		render
	end

	def lakes_crossing_desc
		render
	end

	def lakes_crossing_fund
		render
	end

	def lakes_crossing_obj
		render
	end

	def lakes_crossing_pm
		render
	end

	def lakes_crossing_pop
		render
	end

end
