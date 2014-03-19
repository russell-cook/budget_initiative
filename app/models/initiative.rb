class Initiative < ActiveRecord::Base
	belongs_to :user
	has_many :shares
	validates :user_id, presence: true
  validates :title, presence: true
  validates :lead_agency, presence: true
	accepts_nested_attributes_for :shares
end
