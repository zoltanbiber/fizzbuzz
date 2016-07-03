class MainController < ApplicationController
	# make sure the user is logged in
	# show user's favourites

  def index
    params[:per_page] = '100' unless params[:per_page]
    fizzbuzz = FizzBuzz.new(params)
    if fizzbuzz.valid?
      @numbers = fizzbuzz.numbers
    else
      redirect_to root_path, error: fizzbuzz.errors.full_messages
    end
  end
end
