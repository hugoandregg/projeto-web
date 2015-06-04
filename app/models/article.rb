class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :votes, dependent: :destroy
	belongs_to :user
	
	validates :title, presence: true
	validates :text, presence: true
end
