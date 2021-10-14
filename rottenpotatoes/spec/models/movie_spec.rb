#Additional file added
require 'rails_helper'

#Bot for testing
describe Movie do
    let!(:movie1) { FactoryBot.create(:movie, title: 'The Shining', director: 'Stanley Kubrick') }
    let!(:movie2) { FactoryBot.create(:movie, title: 'Room 237', director: 'Stanley Kubrick') }
    let!(:movie3) { FactoryBot.create(:movie, title: 'Avatar', director: 'James Cameron') }
    let!(:movie4) { FactoryBot.create(:movie, title: 'I do not have a director, I am the sad path')}

    describe 'find with same director' do
        context 'director exists' do
            it 'should return the correct matches for movies by the same director' do
                expect(Movie.find_similar(movie1.title)).to eq(['The Shining', 'Room 237'])
                expect(Movie.find_similar(movie3.title)).to eq(['Avatar'])
            end
            it 'should not return movies by a different director' do
                expect(Movie.find_similar(movie1.title)).to_not include(['Avatar'])
            end
        end
        context 'director does not exist' do
            it 'should return nil' do
                expect(Movie.find_similar(movie4.title)).to eq(nil)
            end
        end
    end
end 