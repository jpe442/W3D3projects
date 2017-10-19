class AddDbConstraintForUsersEmail < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove :email
      t.string :email, null: false, unique: true
    end
  end
end
