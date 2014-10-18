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

  	if params["q"]
			@jobs = Job.get_class_data(PANEL_SHOW[params["q"]])
		else
	 		@jobs = Job.in_effect
		end

		Settings.filter_keywords.each { |keyword| @jobs = @jobs.ignore_company_keyword(keyword) }			
		@in_effect_counts = @jobs.count

		panel

  end

  def panel
  	@shows = {}
		PANEL_SHOW.each do |key, value|
			@shows[key] = Job.get_class_data(value).count
		end
  end


end


