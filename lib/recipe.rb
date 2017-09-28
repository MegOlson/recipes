class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  has_and_belongs_to_many(:ingredients)
  validates(:title, :presence => true)
  validates(:instructions, :presence => true)
  validates(:title, {:presence => true, :length => { :maximum => 50 }})
  before_save(:capitalize_first_letter)


  private

  def capitalize_first_letter
    title = self.title.split(" ")
    self.title = title.map{|word| word.capitalize}.join(" ")
  end

end
