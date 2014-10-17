class TrendsController < ApplicationController

	IGNORE_KEYWORD= [ "茶", "性" , "男", "女", "小三", "LINE", "妹", "全套", "Make Love", "夜", "情", "姐", "妹", "0", "約", "交" ]

  def index

 		@jobs = Job.in_effect

		IGNORE_KEYWORD.each do |keyword|
			@jobs = @jobs.ignore_company_keyword(keyword)
		end

		@in_effect_counts = @jobs.count


  end
end


