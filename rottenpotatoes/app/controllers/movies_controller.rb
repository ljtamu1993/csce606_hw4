class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #Part 1,2,3 starts here:
    # if request.path == '/' #For a default path
    #   reset_session
    # end
    
    @session_sort = session[:sort_by]
    @session_ratings = session[:ratings_to_show]
    @ratings_to_show = !@session_ratings.nil? ? @session_ratings : []
    # if !@session_sort.nil?
    #   # if !params[:sort].nil? and params[:sort] != @session_sort
    #   #   @session_sort = params[:sort]
    #   # end
    #   @sort = @session_sort
    # else
    #   @sort = params[:sort] 
    # end
    @sort = params[:sort]
     @session_sort = @sort  # Added for session record
    
    if !params[:ratings].nil?
      @ratings_to_show = params[:ratings].keys
      @session_ratings = @ratings_to_show
    end
    
    @movies = Movie.with_ratings(@ratings_to_show)
    @all_ratings = Movie.all_ratings
   
    
    #Added for part 2
    #@sort = params[:sort] //Moved up for Part 3 Session data

   if @sort
      @movies = @movies.order(@sort) 
        case @sort
        when "title"
          @title_header = 'bg-warning'
          @release_date_header = 'hilite'
        when "release_date"
          @release_date_header = 'bg-warning'
          @title_header = 'hilite'
        end
    end
    
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def same_dir
    @find_same_dir = Movie.find_same_dir(params[:title])
    if @find_same_dir.nil?
      redirect_to movies_path
      flash[:warning] = "'#{params[:title]}' has no director info"
    end
    @movie = Movie.find_by_title([params[:title]])
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end