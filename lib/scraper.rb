require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  # def get_page
  #   doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
  #   students = doc.css(".student-card a")
    
  # end

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card a")
    
    students.collect do |student|
      student_name = student.css(".card-text-container h4").text
      student_location = student.css(".card-text-container p").text
      student_profile = student.attribute("href").value
      
      student_list = {name: student_name, location: student_location, profile_url: student_profile}
    end
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    
    profile_page = Nokogiri::HTML(open(profile_url))
    
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute("href").value}
    
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
     end
     
     student[:profile_quote] = profile_page.css(".profile-quote").text 
     student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text 
     
     student
  end
     
end

  



#Scraper.new.get_page

#doc.css(".student-card a") returns array of xml info about student
#string of student names: students.css(".card-text-container h4").text
#student locations: students.css(".card-text-container p").text
#student profile: student.attr("href").value

