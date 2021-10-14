class Movie < ActiveRecord::Base
    #For Part 1
    def self.all_ratings()
        # return ['G','PG','PG-13','R']
        return Movie.distinct.pluck(:rating).sort
    end
    
    def self.with_ratings(ratings_list)
        if ratings_list.nil? or ratings_list.empty?
            return Movie.all
        end
        return Movie.where(rating: ratings_list)
    end
    
    def self.find_same_dir(title)
        director = Movie.find_by_title(title).director
        return nil if director.nil? or director.empty?
        return Movie.where(:director => director).pluck(:title)
    end
end