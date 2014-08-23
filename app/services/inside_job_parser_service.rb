require 'open-uri'
require 'nokogiri'

class InsideJobParserService
	
	def initialize(url)
		@url = url
	end

	def parse
		doc = Nokogiri::HTML(open(@url))
		@html =  doc.css('h1').first.text

		@title = @html.split("\n")[0]
		@salary = @html.split("\n")[2]

		@salary_from = @salary[ @salary.index("NT$ ") + 4, @salary.index(" ~ ") - @salary.index("NT$ ") - 4]
		@salary_end = @salary[ @salary.index("~ NT$ ") + 6, @salary.length - @salary.index("~ NT$ ") ]

		if !InsideJob.find_by({ :url => @url })
			InsideJob.create({:title => @title, :salary_form => @salary_form, :salary_end => @salary_end, :url => @url })
		end
	end
end