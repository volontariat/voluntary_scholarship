require 'spec_helper'

describe Scholarship::Iteration do
  describe 'validations' do
    describe '#to_must_be_greater_than_from' do
      context 'to is greater than from' do
        it 'sets no errors for to' do
          iteration = FactoryGirl.build(:scholarship_iteration)
          
          iteration.valid?
          
          iteration.errors[:to].empty?.should be_true
        end
      end
      
      context 'to is smaller than from' do
        it 'sets an error for to' do
          iteration = FactoryGirl.build(:scholarship_iteration, from: Date.new(2014, 9, 1), to: Date.new(2014, 6, 1))
          
          iteration.valid?
          
          iteration.errors[:to].should include(
            I18n.t('activerecord.errors.models.scholarship_iteration.attributes.to.to_must_be_greater_than_from')
          )
        end
      end
    end
  end
end