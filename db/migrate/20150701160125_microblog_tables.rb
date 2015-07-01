class MicroblogTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
    end

    create_table :profiles do |t|
      t.integer :user_id
      t.string :fname
      t.string :lname
      t.string :email
      t.datetime :birthdate
    end

    create_table :blogs do |t|
      t.integer :user_id
      t.string :content
    end

  end
end
