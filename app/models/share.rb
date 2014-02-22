class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :initiative
  accepts_nested_attributes_for :initiative
end
