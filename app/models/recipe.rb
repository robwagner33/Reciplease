class Recipe < ActiveRecord::Base
  
  ## Validations
  validates_presence_of :name, :owner, :description, :instructions
  validates_uniqueness_of :name, :case_sensitive => false, :scope => [:owner_id, :base_id]

  ## Relationships
  belongs_to :owner, :class_name => "User"
  # should we add in User: has_many :recipes, :foreign_key => "owner_id" ?
  belongs_to :base, :class_name => "Recipe"
  has_many :forks, :class_name => "Recipe", :foreign_key => "base_id"
  
  # User Favorites
  has_many :fav_recipes
  has_many :users, :through => :fav_recipes
  
  # included ingredient descriptions can be accessed indirectly through the many-to-many table 'ingredient'
  has_many :ingredients
  has_many :ingredient_descs, :through => :ingredients
  
  ## Accessibile attributes
  attr_accessible :name, :owner_id, :description, :instructions, :base, :forks, :ingredients, :image
  # TODO we should limit the length of :description 
  
  attr_accessor :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  
  has_attached_file :image, styles: {
    thumb: '100x100',
    square: '200x200',
    medium: '300x300'
  }
  
  def to_param
    "#{id}/#{name}"
  end
end
