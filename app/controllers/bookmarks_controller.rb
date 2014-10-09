class BookmarksController < ApplicationController
  before_action :find_bookmark, only: [:show, :edit, :update, :destroy]

  def index
    # first, find all the bookmarks from the database
    # Bookmark.all runs: SELECT * FROM bookmarks;
    @bookmarks = Bookmark.order(:title)
  end

  def show
  end

  def new
    # used as an empty placeholder object in the html form
    # this object does not yet exist in the database
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # now this object exists but is not yet saved to the database
    if @bookmark.save
      redirect_to action: :index # redirect_to IS a new HTTP request
    else
      render :new # render is not a new HTTP request, otherwise we would create 2 new objects - render looks for the view template of the matching name
    end
  end

  def edit
  end

  def update
    if @bookmark.update_attributes(bookmark_params)
      redirect_to action: :index
    else
      render :edit # render looks for the view template of the matching name
    end
  end

  def destroy
    # first find the object we want to delete
    # destroy is better than delete because destroy will also remove any orphan rows from the database, as well as any child dependents
    @bookmark.destroy
    redirect_to action: :index
  end

  private

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :title, :comment, :favorite)
  end

end
