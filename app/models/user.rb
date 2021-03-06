class User < ActiveRecord::Base
	has_many :initiatives, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_many :shares, through: :initiatives
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
