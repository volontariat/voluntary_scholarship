create_table :scholarship_programs do |t|
  t.integer :organization_id
  t.string :name
  t.text :text
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

create_table :scholarship_teams do |t|
  t.string :name
  t.text :text
  t.string :kind
  t.string :github_handle
  t.string :twitter_handle
  t.string :state
  t.timestamps
end 

add_index :scholarship_teams, :name, unique: true

create_table :scholarship_team_memberships do |t|
  t.integer :team_id
  t.integer :user_id
  t.integer :roles # :team_leader, :student, :coach, :mentor, :supervisor
  t.string :state
  t.timestamps
end 

add_index :scholarship_team_members, [:team_id, :user_id], unique: true

create_table :scholarship_iteration_participations do |t|
  t.integer :iteration_id
  t.integer :user_id
  t.integer :roles
  t.integer :team_id
  t.text :text
  t.string :state
  t.timestamps
end 

add_index :scholarship_iteration_participations, [:iteration_id, :user_id], unique: true, name: 'index_scholarship_iteration_participations_on_iteration_user'

create_table :scholarship_iterations_teams do |t|
  t.integer :iteration_id
  t.integer :team_id
  t.date :start
  t.date :end
  t.string :state
  t.timestamps
end 
  
add_index :scholarship_program_user_roles, [:iteration_id, :user_id], unique: true, name: 'index_scholarship_program_user_roles_on_iteration_user'

add_column :users, :github_handle, :string unless User.new.respond_to? :github_handle
add_column :users, :twitter_handle, :string unless User.new.respond_to? :twitter_handle
add_column :users, :irc_handle, :string unless User.new.respond_to? :irc_handle
add_column :users, :timezone, :string unless User.new.respond_to? :timezone
add_column :users, :location, :string unless User.new.respond_to? :location

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
  