class Reports::WithdrawalPerPersonsController < ApplicationController
	def index
		render :partial => 'index'
	end
end
