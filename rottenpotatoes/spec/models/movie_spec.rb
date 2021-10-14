#Additional file added
require 'rails_helper'
require 'workaround'
require 'simplecov'
SimpleCov.start 'rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
# then, whenever you need to clean the DB
# before do
#     DatabaseCleaner.clean
# end

DatabaseCleaner.clean

# RSpec.describe Movie, type: :model do
#     it "returns same_dir movies" do
#         movie_1 = Movie.create(title: 'movie_1', director: 'director1')
#         movie_2 = Movie.create(title: 'movie_2', director: 'director1')
#         movie_3 = Movie.create(title: 'movie_3', director: 'director2')
#         expect(Movie.find_same_dir(movie_1.title)) == [movie_1, movie_2]
#         expect(Movie.find_same_dir(movie_1.title)) != [movie_1, movie_2, movie_3]
#     end
        
# end

#Bot for testing
describe Movie do
    let!(:movie1) { FactoryBot.create(:movie, title: 'The Incredibles', rating: 'PG', director: 'Brad Bird') }
    let!(:movie2) { FactoryBot.create(:movie, title: 'The Incredibles II', rating: 'PG', director: 'Brad Bird') }
    let!(:movie3) { FactoryBot.create(:movie, title: 'Avatar', rating: 'PG', director: 'James Cameron') }
    let!(:movie4) { FactoryBot.create(:movie, title: 'Movie with no director', rating: 'PG-13', director: 'Amran Haroon')}

    describe 'with_ratings' do
        context 'rating list is empty' do
            it 'should return all movies' do
                expect(Movie.with_ratings(nil)).to eq([movie1, movie2, movie3, movie4])
            end
        end
        context 'rating list contains values' do
            it 'should return all movies that match the rating list' do
                expect(Movie.with_ratings(['PG'])).to eq([movie1, movie2, movie3])
            end
        end
    end

    describe 'all_ratings' do
        it 'it should return all ratings that are present in the movie list' do
            expect(Movie.all_ratings()).to eq(['PG','PG-13'])
        end
    end

    describe 'find_same_dir' do
        context 'director exists' do
            it 'should return the correct matches for movies by the same director' do
                expect(Movie.find_same_dir(movie1.title)).to eq(['The Incredibles', 'The Incredibles II'])
                expect(Movie.find_same_dir(movie3.title)).to eq(['Avatar'])
            end
            it 'should not return movies by a different director' do
                expect(Movie.find_same_dir(movie1.title)).to_not include(['Avatar'])
            end
        end
        context 'director does not exist' do
            it 'should return correct matches for movies with no directors' do
                expect(Movie.find_same_dir(movie4.title)).to eq(nil || ['Movie with no director'])
            end
        end
    end
end

DatabaseCleaner.clean
# after do
#     DatabaseCleaner.clean
# end