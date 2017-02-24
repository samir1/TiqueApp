module CodesHelper
    def my_codes
        if logged_in?
            Code.where(owner: current_user.id).where.not(code_type:'personal')
        end
    end

    def get_name_from_email(email)
        user = User.find_by(email: email)
        user.try(:fname).to_s + ' ' + user.try(:lname).to_s if !user.nil?
    end
end
