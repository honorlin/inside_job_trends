class Job < ActiveRecord::Base
	default_scope { order(:post_date => :desc) }

	def self.ignore_company_keyword(keyword)
		where.not("company LIKE ?", "%#{keyword}%")
	end

	def self.in_effect
		where("effective_date > ?", Time.now)
	end

	def self.get_class_data(keywords)
		job = in_effect
		condition = ""
		keywords.each { |keyword| condition += with_contains_keyword(keyword)}
		condition = condition[0 , condition.length - 3 ]
		job.where(condition)
	end

	def self.with_contains_keyword(keyword)
		"lower(job_info) LIKE '%#{keyword.downcase}%' or lower(title) LIKE '%#{keyword.downcase}%' or lower(location) LIKE '%#{keyword.downcase}%' or "
	end


end
