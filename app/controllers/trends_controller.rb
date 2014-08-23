class TrendsController < ApplicationController
  def index

  inside_job_parser_serice = InsideJobParserService.new("http://jobs.inside.com.tw/jobs/5227-getmore%E4%BA%8C%E6%AC%A1%E6%99%82%E5%B0%9A%E8%A1%8C%E9%8A%B7bd%E5%AF%A6%E7%BF%92%E7%94%9F-getmore%E4%BA%8C%E6%AC%A1%E6%99%82%E5%B0%9A")

  end
end
