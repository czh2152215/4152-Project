require 'rails_helper'

RSpec.describe Artwork, type: :model do
  # Test for presence validation
  describe 'validations' do
    it 'is not valid without an artwork_name' do
      artwork = Artwork.new(artwork_name: nil)
      expect(artwork).not_to be_valid
      expect(artwork.errors[:artwork_name]).to include("can't be blank")
    end

    it 'is valid with an artwork_name' do
      artwork = Artwork.new(artwork_name: 'Mona Lisa')
      expect(artwork).to be_valid
    end
  end

end

