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
      t.string :city
    end

    create_table :blogs do |t|
      t.integer :user_id
      t.string :content
    end

    create_table :user_blogs do |t|
      t.integer :user_id
      t.integer :blog_id
    end

  end
end
