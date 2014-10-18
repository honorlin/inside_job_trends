class TrendsController < ApplicationController

  def index

 		@jobs = Job.in_effect

		Settings.filter_keywords.each do |keyword|
			@jobs = @jobs.ignore_company_keyword(keyword)
		end

		@in_effect_counts = @jobs.count


  end


end


