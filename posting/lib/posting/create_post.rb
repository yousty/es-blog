module Posting
  class CreatePost < Command
    attribute :post_id, Types::UUID
    attribute :author, Types::Strict::String
    attribute :content, Types::Strict::String
    attribute :title, Types::Strict::String

    alias :aggregate_id :post_id
  end
end
