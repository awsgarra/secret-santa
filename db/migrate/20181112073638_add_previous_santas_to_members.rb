class AddPreviousSantasToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :previous_santas, :json, default: {}
  end
end
