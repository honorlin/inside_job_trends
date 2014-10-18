class Job < ActiveRecord::Base
	default_scope { order(:post_date => :desc) }

	def self.ignore_company_keyword(keyword)
		where.not("company LIKE ?", "%#{keyword}%")
	end

	def self.in_effect
		where("effective_date > ?", Time.now)
	end

	def self.get_keywords_count(keywords)
			job = in_effect
			keywords.each { |keyword| job = job.with_contains_keyword(keyword) }
			job.count
	end

	def self.with_contains_keyword(keyword)
		where("lower(job_info) LIKE ?", "%#{keyword.downcase}%")
	end


end
