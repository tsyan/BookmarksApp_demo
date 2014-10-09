class BookmarksController < ApplicationController

  def index
    # first, find all the bookmarks from the database
    # Bookmark.all runs: SELECT * FROM bookmarks;
    @bookmarks = Bookmark.all
  end

end
