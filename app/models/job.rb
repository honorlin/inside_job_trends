class Job < ActiveRecord::Base
	default_scope { order(:post_date => :desc) }

	def self.ignore_keyword(keyword)
		where.not("company LIKE ?", "%#{keyword}%")
	end

	def self.in_effect
		where("effective_date > ?", Time.now)
	end


end
