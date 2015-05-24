module ApplicationHelper
	def flash_type(key)
		if [:success, :info, :warning].include? key
			"alert-#{key}"
		else
			"alert-danger"
		end
	end

	def is_active?(link_path)
		current_page?(link_path) ? "active" : ""
	end
end
