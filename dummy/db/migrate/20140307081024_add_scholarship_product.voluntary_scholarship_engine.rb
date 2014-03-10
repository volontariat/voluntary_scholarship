# This migration comes from voluntary_scholarship_engine (originally 20140306201232)
class AddScholarshipProduct < ActiveRecord::Migration
  def up
    if product = Product.where(name: 'Scholarship').first
    else
      Product.create(name: 'Scholarship', text: 'Dummy') 
    end
  end
  
  def down
    product.destroy if product = Product.where(name: 'Scholarship').first
  end
end
