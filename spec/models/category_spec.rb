require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'before publication' do
    it 'validates uniqueness of name' do
      Category.create! :name => 'test'
      expect { Category.create! :name => 'test' }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates the presence of name' do
      expect { Category.create! :name => '' }.to raise_error(ActiveRecord::RecordInvalid)
    end

    describe "before_save callback" do
      it 'converts the name to downcase' do
        category = Category.create! :name => 'TEST_CATEGORY'
        expect(category.name).to eq 'TEST_CATEGORY'.downcase
      end
    end
  end
end
