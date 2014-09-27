class TrendsController < ApplicationController

	IGNORE_KEYWORD= [ "茶", "性" , "男", "女"]

  def index

 		@inside_jobs = InsideJob.in_effect

		IGNORE_KEYWORD.each do |keyword|
			@inside_jobs = @inside_jobs.ignore_keyword(keyword)
		end

		@in_effect_counts = @inside_jobs.count


  end
end


