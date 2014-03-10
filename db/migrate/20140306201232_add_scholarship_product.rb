class AddScholarshipProduct < ActiveRecord::Migration
  def change
    Product.create(name: 'Scholarship', text: 'Dummy')
  end
end
