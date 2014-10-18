require 'open-uri'
require 'nokogiri'

class InsideJobUrlParserWithFilter

	def initialize(url)
		@url = url
	end

	def call

		begin

			html = Nokogiri::HTML(open(@url))

			html.css('li.job').each do |job|
				company_name = job.css(".role h3").text	
				job_url = job.css("a")[0]["href"]

				unless is_filted(company_name)
					Job.create({ :url => job_url}) if !Job.find_by({ :url => job_url })
				end

			end

		rescue Exception => e
			Rails.logger.info e.message
			Rails.logger.info @url		
		end

	end

private

	def is_filted(company_name)
		Settings.filter_keywords.any? { |keyword| company_name.include? keyword }
	end

end