class Product < ActiveRecord::Base
  has_many :categorisations
  has_many :categories, :through => :categorisations

  after_save ThinkingSphinx::RealTime::Callbacks::RealTimeCallbacks.new(:product)
end
