class TrendsController < ApplicationController

	IGNORE_KEYWORD= [ "茶", "性" ]

  def index

 		@inside_jobs = InsideJob

		IGNORE_KEYWORD.each do |keyword|
			@inside_jobs = @inside_jobs.ignore_keyword(keyword)
		end

  end
end


