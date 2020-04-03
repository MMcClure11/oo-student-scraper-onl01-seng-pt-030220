require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # def get_student_profile
  #   doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"))
  #   binding.pry
  # end

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_page = doc.css(".student-card a")
    students = []

    student_page.each do |student|
      students << {
        name: student.css(".card-text-container h4").text,
        location: student.css(".card-text-container p").text,
        profile_url: student.attr('href')
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text
    
    social_media = doc.css(".social-icon-container a")
    social_media.each do |social_type|
      link = social_type.attr('href')
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student
  end

end

# Scraper.new.get_student_profile

#students = doc.css(".student-card a") returns info about the student
#student_name students.css(".card-text-container h4").first.text
#student_location students.css(".card-text-container p").first.text
#student_profile_url students.attr('href')

# :profile_quote => doc.css(".profile-quote").text
# :bio => doc.css(".description-holder p").text
# social_media = doc.css(".social-icon-container a").attr('href').value
#social_media.each do |social_type|
  # link = social_type.attr('href').value
  # if link.include?("twitter")
  #   student_profile[:twitter] = link
