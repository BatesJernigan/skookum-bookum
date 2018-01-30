require 'net/http'
require 'json'

class BooksController < ApplicationController
  ALL_BOOKS_URL = 'https://skookum-test-api.herokuapp.com/api/v1/books'.freeze

  def index
    @books = all_books
  end

  private

  # @return Array<Hash[title:, author:, year:, isbn:]>
  def all_books
    response = Net::HTTP.get(URI(ALL_BOOKS_URL))
    JSON.parse(response)
  end
end
