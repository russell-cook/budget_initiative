class Initiative < ActiveRecord::Base
	belongs_to :user
	has_many :shares
	validates :user_id, presence: true
end
