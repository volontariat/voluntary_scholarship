class CreateScholarshipPrograms < ActiveRecord::Migration
  def change
    create_table :scholarship_programs do |t|
      t.integer :organization_id
      t.string :name
      t.text :text
      t.timestamps
    end 
    
    add_index :scholarship_programs, [:organization_id, :name], unique: true
  end
end
