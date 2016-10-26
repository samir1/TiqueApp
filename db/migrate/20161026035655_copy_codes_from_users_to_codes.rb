class CopyCodesFromUsersToCodes < ActiveRecord::Migration[5.0]
  def change
    User.all.each do |user|
        code = Code.find_by(owner: user.id, code_type: "personal")
        if !code
            Code.create owner: user.id, code_value: user.user_code, title: "Personal Code", code_type: "personal"
        elsif code
            code.code_value = user.user_code
            code.save!
        end
    end
  end
end