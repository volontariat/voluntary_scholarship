class CreateScholarshipIterations < ActiveRecord::Migration
  def change
    create_table :scholarship_iterations do |t|
      t.integer :program_id
      t.string :name
      t.datetime :from
      t.datetime :to
      t.timestamps
    end 
    
    add_index :scholarship_iterations, [:program_id, :from, :to], unique: true
  end
end
