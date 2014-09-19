class InsideJob < ActiveRecord::Base
	default_scope { order(:post_date => :desc) }

	def self.ignore_keyword(keyword)
		where.not("company LIKE ?", "%#{keyword}%")
	end
end
