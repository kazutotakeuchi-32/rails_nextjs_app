# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  def paginate(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      next_page: collection.next_page,
      prev_page: collection.prev_page
    }
  end
end
