module CodesHelper
    def my_codes
        if logged_in?
            Code.where(owner: current_user.id)
        end
    end
end
