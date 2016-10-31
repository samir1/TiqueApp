class UpdateCritiquesToUseCode < ActiveRecord::Migration[5.0]
  def change
    Critique.all.each do |crit|
        code = Code.find_by(owner: crit.code_value, code_type: "personal")
        if code && crit.code_value.to_s.length < 4
            crit.code_value = code.code_value
            crit.save!
        end
    end
  end
end
