class TrendsController < ApplicationController

	IGNORE_KEYWORD= [ "茶", "性" , "男", "女"]

  def index

 		@jobs = Job.in_effect

		IGNORE_KEYWORD.each do |keyword|
			@jobs = @jobs.ignore_keyword(keyword)
		end

		@in_effect_counts = @jobs.count


  end
end


