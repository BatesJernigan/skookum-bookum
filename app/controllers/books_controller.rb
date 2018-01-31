require 'net/http'
require 'json'
require 'will_paginate/array'

class BooksController < ApplicationController
  ALL_BOOKS_URL = 'https://skookum-test-api.herokuapp.com/api/v1/books'.freeze

  def index
    @books = filtered_books
    @paginated_books = @books.paginate(page: page_params[:page], per_page: 20)
  end

  def search_params
    params.require(:q).permit(:title, :author, :year, :isbn)
  end
  helper_method :search_params

  def page_params
    params.permit(:page)
  end

  private

  # @return Array<Hash[title:, author:, year:, isbn:]>
  def all_books
    Rails.cache.fetch("#{session_cache_key}/books#all_books", expires_in: 1.hour) do
      response = Net::HTTP.get(URI(ALL_BOOKS_URL))
      JSON.parse(response)
    end
  rescue JSON::ParserError
    {}
  end

  def filtered_books
    if params[:q].present?
      all_books.select { |book| book.slice(*search_params.keys) == search_params }
    else
      all_books
    end
  end
end
