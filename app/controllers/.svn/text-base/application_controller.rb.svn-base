# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	
	include AuthenticatedSystem
	
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  layout 'vin'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def render_update_page(dom_id, partial, locals = {}, msg = nil)
    render :update do |page|
      page << "$('##{dom_id}').html('#{ escape_javascript(render :partial => partial, :locals => locals) }')" 
      
      if msg
        page << "$('#message_area').html('#{msg}')"
        page << "$('#message_area').slideDown()"
      end
    end
  end
  
  	
	def stream_csv 
		filename ||= 'summary'<<"#{Time.now.to_s(:db)}"
		filename = filename + '.csv'

		# this is required if you want this to work with IE        
		if request.env['HTTP_USER_AGENT'] =~ /msie/i
			headers['Pragma'] = 'public'
			headers["Content-type"] = "text/plain" 
			headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
			headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
			headers['Expires'] = "0" 
		else
			headers["Content-Type"] ||= 'text/csv'
			headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
		end

		render :text => Proc.new { |response, output|
			csv = FasterCSV.new(output, :row_sep => "\r\n") 
			yield csv
		}
	end
  
end
