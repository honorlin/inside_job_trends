require 'open-uri'
require 'nokogiri'

class InsideJobParserService
	
	def initialize(url)
		@url = url
	end

	def parse
		doc = Nokogiri::HTML(open("http://jobs.inside.com.tw/#{@url}"))

		@company = doc.css('.company-name').first.text
		@html =  doc.css('h1').first.text
	
		@title = @html.split("\n")[0]
		@salary = @html.split("\n")[2]

		#@salary_from = @salary[ @salary.index("NT$ ") + 4, @salary.index(" ~ ") - @salary.index("NT$ ") - 4 ]
		#@salary_end = @salary[ @salary.index("~ NT$ ") + 6, @salary.length - @salary.index("~ NT$ ") ]

		@job_content = doc.css('#job-info').first.text

		@date =  doc.css('.date').first.text
		@date = @date.split("\n")

		@post_date = @date[2]
		@effective_date = @date[4]

		@inside_job = Job.find_by({ :url => @url })

		#if @inside_job.title.blank?
		@inside_job.update_attributes({ :company => @company , :title => @title, :salary => @salary,  :url => @url, :post_date => @post_date, :effective_date => @effective_date, :job_content => @job_content })
		#end


	end
end