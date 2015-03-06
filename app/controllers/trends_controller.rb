class TrendsController < ApplicationController

	PANEL_SHOW = {

		"前端工程師" => [ "前端", "frontend", "front-end", "front end" ],
		"後端工程師" => [ "後端", "backend", "back-end", "back end" ],
		"視覺設計師" => [ "視覺", "設計師" ],
		"平面設計師" => [ "	平面" ],
		"行銷" => [ "行銷" ],
		"客服" => [ "客服" ],
		"外商" => [ "外商" ],
		"美商" => [ "美商" ],
		"業務" => [ "業務", "sales" ],
		"企劃" => [ "企劃" ],
		"文案編輯" => [ "編輯" ],
		"工讀生" => [ "工讀" ],
		"實習生" => [ "實習" ],
		"新創公司" => [ "新創", "startup" ],
		"Ruby on Rails" => [ "rails" ],
		"Node.js" => [ "nodejs", "node.js" ],
		"Python" => [ "python" ],
		"PHP" => [ "php" ],
		".NET" => [ ".net" ],
		"Java" => [ "java" ],
		"iOS" => [ "ios" ],
		"Android" => [ "android" ],
		"JaveScript" => [ "JavaScript" ],
		"UX/UI Designer" => [ "ui", "ux" ],
		"TechLeader" => [ "lead", "leader", "總監" ],
		"Embedded" => [ "embedded"],
		"台北" => [ "台北", "taipei" ],
		"台中" => [ "台中", "taichung" ],
		"台南" => [ "台南", "tainan" ],
		"高雄" => [ "高雄", "kaohsiung" ],
		"新北" => [ "新北" ],
		"新竹" => [ "新竹" ],
		"舊金山" => [ "舊金山" ]

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


