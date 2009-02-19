class Product < ActiveRecord::Base
  has_many :orders, :through => :line_items
  has_many :line_items
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validates_uniqueness_of :title, :message => 'entered is already in use ' +
    'by another produce.'
  validate :price_must_be_at_least_a_cent
  validates_format_of :image_url,:with => %r{\.(gif|jpg|png)$}i,
                      :message => 'must be a URL for GIF, JPG or PNG image.'
  validates_length_of :title, :minimum => 10, :message => "seems too short"


  def self.find_products_for_sale
    find(:all, :order => "title")
  end

  protected

  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be at least 1 cent') if price.nil? ||
      price < 1
  end

end
