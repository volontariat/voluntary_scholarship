# This migration comes from voluntary_scholarship_engine (originally 20140306201232)
class AddScholarshipProduct < ActiveRecord::Migration
  def change
    create_table :scholarship_programs do |t|
      t.integer :organization_id
      t.string :name
      t.timestamps
    end 
    
    add_index :scholarship_programs, [:organization_id, :name], unique: true
    
    create_table :scholarship_iterations do |t|
      t.integer :program_id
      t.string :name
      t.datetime :start
      t.datetime :end
      t.timestamps
    end 
    
    add_index :scholarship_iterations, [:program_id, :start, :end], unique: true
    
    create_table :scholarship_iterations_teams do |t|
      t.integer :iteration_id
      t.integer :team_id
      t.date :start
      t.date :end
      t.string :state
      t.timestamps
    end 
    
    create_table :scholarship_teams do |t|
      t.integer :program_id
      t.string :name
      t.text :description
      t.string :kind
      t.string :github_handle
      t.string :twitter_handle
      t.string :state
      t.timestamps
    end 
    
    add_index :scholarship_teams, [:program_id, :name], unique: true
    
    create_table :scholarship_roles do |t|
      t.string :name
      t.timestamps
    end 
    
    add_index :scholarship_roles, :name, unique: true
    
    create_table :scholarship_program_roles do |t|
      t.integer :program_id
      t.integer :role_id
      t.timestamps
    end
    
    add_index :scholarship_program_roles, [:program_id, :role_id], unique: true 
    
    create_table :scholarship_program_user_roles do |t|
      t.integer :program_id
      t.integer :user_id
      t.integer :role_id
      t.integer :team_id
      t.text :covering_letter
      t.string :state
      t.timestamps
    end 
   
    add_index :scholarship_program_user_roles, [:program_id, :user_id, :role_id], unique: true, name: 'index_scholarship_program_user_roles_on_program_user_role'
    
    add_column :users, :github_handle, :string unless User.new.respond_to? :github_handle
    add_column :users, :twitter_handle, :string unless User.new.respond_to? :twitter_handle
    add_column :users, :irc_handle, :string unless User.new.respond_to? :irc_handle
    add_column :users, :timezone, :string unless User.new.respond_to? :timezone
    add_column :users, :location, :string unless User.new.respond_to? :location
  end
end
