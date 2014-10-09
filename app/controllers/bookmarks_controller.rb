class BookmarksController < ApplicationController

  def index
    # first, find all the bookmarks from the database
    # Bookmark.all runs: SELECT * FROM bookmarks;
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    # used as an empty placeholder object in the html form
    # this object does not yet exist in the database
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.create(bookmark_params)
    # now this object is saved in the database
    redirect_to action: :index
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.update_attributes(bookmark_params)
    redirect_to action: :index
  end

  def destroy
    # first find the object we want to delete
    @bookmark = Bookmark.find(params[:id])
    # destroy is better than delete because destroy will also remove any orphan rows from the database, as well as any child dependents
    @bookmark.destroy
    redirect_to action: :index
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :title, :comment, :favorite)
  end

end
