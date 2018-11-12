class CreateSecretSantas < ActiveRecord::Migration[5.1]
  def change
    create_table :secret_santas do |t|
      t.belongs_to :member
      t.belongs_to :chosen_member
      t.index [:member_id, :chosen_member_id], unique: true
      t.timestamps
    end
  end
end
