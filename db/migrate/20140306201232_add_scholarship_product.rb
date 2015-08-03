class AddScholarshipProduct < ActiveRecord::Migration
  def up
    if Product::Scholarship.first
    else
      Product::Scholarship.create(name: 'Scholarship', text: 'Dummy') 
    end
  end
  
  def down
    product.destroy if product = Product::Scholarship.first
  end
end