namespace :ycom do
  desc "Scrape breads"
  task :scrape_news => :environment do
    require 'open-uri'
    require 'nokogiri'
    document = open('https://news.ycombinator.com/')
    content = document.read
    parsed_conntent = Nokogiri::HTML(content)
    parsed_conntent.css('.itemlist').css('.storylink').each do |story|
     if (@link = Link.find_by(title: story.inner_text)).present?
       #if link is already present increase one comment and vote
       @link.comments.create(body: story.inner_text, user_id: User.last)
       @link.liked_by User.last
     else
       Link.create(title: story.inner_text, url: story.values.first, user_id: User.last.id )
     end
    end
  end
end