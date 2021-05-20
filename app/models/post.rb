require 'elasticsearch/model'

class Post < ApplicationRecord
  belongs_to :user
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  settings index: { number_of_shards: 1 }

  after_save :elasticsearch_update_index

  private

  def elasticsearch_update_index
    Post.find_each { |post| post.__elasticsearch__.index_document }
  end
end
