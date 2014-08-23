require 'open-uri'
require 'nokogiri'

class InsideJobUrlParserService

	def initialize(url)
		@url = url
	end

	def parse
		@html = open(@url) {|f| f.read }

		@text = ""

		@html.scan(/<li class="job" id="job_.+\n<a href=".+/) do |url|
			
			match_url = /jobs\/.+/.match(url)[0]
			job_url = match_url[0, match_url.length - 2]
			
			if !InsideJob.find_by({ :url => job_url })
				InsideJob.create({ :url => job_url})	
			end
		end

	end
end