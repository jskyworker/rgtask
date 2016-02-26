class TodoList < ActiveRecord::Base
  has_many :todo_items
  accepts_nested_attributes_for :todo_items, reject_if: proc { |attributes| attributes['content'].blank? }
  validates :title, presence: true
  validates :title, length: { minimum: 3 }


  def has_completed_items?
  	todo_items.complete.size > 0
  end

  def has_incompleted_items?
  	todo_items.incomplete.size > 0
  end
end
