class DashboardController < ApplicationController
  def index
    if params[:q].present?
      # @results = Elasticsearch::Model.search(params[:q]).records
      @results = Post.__elasticsearch__.search(
        query: {
          # multi_match: {
          #   query: "#{params[:q]}*",
          #   fields: ['title', 'description', 'tag']
          # }
          query_string: {
            query: "*#{params[:q]}*"
          }
        }).results
      @results = @results.results
      respond_to do |format|
        format.html
        format.js
      end
    else
      @results = Post.all
    end
  end
end
