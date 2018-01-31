module BooksHelper
  %w[title author year isbn].each do |book_param|
    define_method "all_book_#{book_param.pluralize}" do
      Rails.cache.fetch("#{session_cache_key}/books#all_book_#{book_param}", expires_in: 1.hour) do
        @books.map { |book| book[book_param].presence }.compact.uniq.sort
      end
    end
  end
end
