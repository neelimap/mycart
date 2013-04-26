module LoginHelper
	def checkuser
      !current_user.nil?
    end
end
