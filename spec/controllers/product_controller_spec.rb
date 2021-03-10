require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    validates :name, presence: true
    validates :price, presence: true
    validates :quantity, presence: true
    validates :category, presence: true
  end
end