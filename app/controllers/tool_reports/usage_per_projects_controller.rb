class ToolReports::UsagePerProjectsController < ApplicationController
	def index
		render :partial => 'index'
	end
end
