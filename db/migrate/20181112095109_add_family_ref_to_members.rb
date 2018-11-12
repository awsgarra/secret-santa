class AddFamilyRefToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :family_id, :integer
    add_foreign_key :members, :families
  end
end
