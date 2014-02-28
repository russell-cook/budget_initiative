class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :registerable, :recoverable, :trackable, :validatable
  devise :database_authenticatable, :timeoutable, :rememberable
end
