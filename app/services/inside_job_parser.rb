require 'open-uri'
require 'nokogiri'

class InsideJobParser
	
	def initialize(url)
		@url = url
	end

	def call
		html = Nokogiri::HTML(open("http://jobs.inside.com.tw/#{@url}"))

		@company = html.css('.company-name').text
		@url = html.css(".url a")[0]["href"] if html.css(".url a").present?
		@title = html.css(".content h1")[0].inner_html.split("\n")[0]
		@job_class = html.css(".content h1 span")[0].inner_html.split("：")[1]
		@salary = html.css(".content h1 span")[1].inner_html.split("：")[1]
		@salary_from = @salary.split("~")[0].gsub("NT$", "").gsub(" ", "")
		@salary_end = @salary.split("~")[1].split("，")[0].gsub("NT$", "").gsub(" ", "")
		@annual_salary = @salary.split("~")[1].split("，")[1].gsub("年薪可達", "").gsub("NT$", "").gsub(" ", "") if @salary.split("~")[1].split("，")[1]
		@location = html.css(".content .location").text
		@post_date = html.css(".content .date").inner_html.split("\n")[2]
		@effective_date = html.css(".content .date").inner_html.split("\n")[4]
		@job_info = html.css("#job-info").inner_html
		@apply_info = html.css("#apply-info").inner_html

		@inside_job = Job.find_by({ :url => @url })

		if @inside_job.title.blank?
			@inside_job.update_attributes(
				:company => @company, 
				:url => @url,
				:title => @title,
				:job_class => @job_class,
				:salary => @salary,
				:salary_from => @salary_from,
				:salary_end => @salary_end,
				:annual_salary => @annual_salary,
				:location => @location,
				:post_date => @post_date,
				:effective_date => @effective_date,
				:job_info => @job_info,
				:apply_info => @apply_info
			)
		end if @inside_job
	end
end