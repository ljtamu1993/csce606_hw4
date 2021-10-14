class Movie < ActiveRecord::Base
    def self.find_similar(title)
        director = Movie.find_by_title(title).director
        return nil if director.nil? or director.empty?
        return Movie.where(:director => director).pluck(:title)
    end
end
