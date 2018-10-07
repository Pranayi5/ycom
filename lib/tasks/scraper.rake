def evaluate_posted_on(sub_text)
  posted_on_data = sub_text.css('.age').children[0].inner_text
  posted_on_val = posted_on_data.split(" ")[0].to_i
  if posted_on_data.include? "sec"
    posted_on = DateTime.now() - posted_on_val.seconds
  elsif posted_on_data.include? "min"
    posted_on = DateTime.now() - posted_on_val.minutes
  elsif posted_on_data.include? "hour"
    posted_on = DateTime.now() - posted_on_val.hours
  elsif posted_on_data.include? "day"
    posted_on = DateTime.now() - posted_on_val.days
  elsif posted_on_data.include? "week"
    posted_on = DateTime.now() - posted_on_val.weeks
  elsif posted_on_data.include? "month"
    posted_on = DateTime.now() - posted_on_val.months
  else
    posted_on = DateTime.now() - posted_on_val.years
  end
  posted_on
end

def evaluate_comments_count(sub_text)
  comments_count = sub_text.css('a').children.last.inner_text
  if comments_count.include? "comment"
    comments_count = comments_count.to_i
  else
    comments_count = 0
  end
  comments_count
end

def evaluate_votes_count(sub_text)
  votes_count = 0
  if sub_text.css('.score').present?
    votes_count = sub_text.css('.score').children[0].inner_text.split(' ').first.to_i
  end
  votes_count
end

def crawl_url(url)
  document = open(url)
  content = document.read
  parsed_content = Nokogiri::HTML(content)
  parsed_content.css('.athing').each do |item|

    ycom_item_id = item.values[1]
    p "processing ycom item id: " + ycom_item_id.to_s


    sub_text = item.next_element

    title = item.children.css('.storylink').inner_text
    external_url = item.children.css('.storylink').first.attributes["href"].value
    ycom_url = "https://news.ycombinator.com/item?id=" + ycom_item_id.to_s
    votes_count = evaluate_votes_count(sub_text)
    comments_count = evaluate_comments_count(sub_text)
    posted_on = evaluate_posted_on(sub_text)

    @news_article = NewsArticle.find_by(ycom_item_id: ycom_item_id)
    if  @news_article.present?
      @news_article.update_attributes(comments_count: comments_count, votes_count: votes_count)
    else
      NewsArticle.create( ycom_item_id: ycom_item_id, title: title, external_url: external_url, ycom_url: ycom_url, comments_count: comments_count, votes_count: votes_count, posted_on: posted_on)
    end
  end
end

namespace :ycom do
  desc "Scrape ycombinator"

  task :scrape_news => :environment do

    require 'open-uri'
    require 'nokogiri'

    base_url = 'https://news.ycombinator.com/news?p='
    pages_to_crawl = [1,2,3]

    pages_to_crawl.each do |page_no|
      crawl_url(base_url + page_no.to_s)
    end

  end
end