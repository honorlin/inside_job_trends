class TrendsController < ApplicationController

	PANEL_SHOW = {

		"前端工程師" => [ "前端" ],
		"後端工程師" => [ "後端" ],
		"Ruby on Rails" => [ "rails" ],
		"NodeJs" => [ "nodejs" ],
		"Python" => [ "python" ],
		"PHP" => [ "php" ],
		".NET" => [ ".net" ],
		"Java" => [ "java" ],
		"iOS" => [ "ios" ],
		"Android" => [ "android" ],
		"JaveScript" => [ "JaveScript" ],
		"外商" => [ "外商" ],
		"美商" => [ "美商" ]
	}


  def index

 		@jobs = Job.in_effect

		Settings.filter_keywords.each do |keyword|
			@jobs = @jobs.ignore_company_keyword(keyword)
		end

		@in_effect_counts = @jobs.count

		@shows = {}
	
		PANEL_SHOW.each do |key, value|
			@shows[key] = Job.get_keywords_count(value)
		end



		Rails.logger.info @shows.to_s

  end


end


