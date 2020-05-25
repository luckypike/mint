class SearchController < ApplicationController
  before_action :authorize_search

  def index
    respond_to do |format|
      format.html { render :index }
      format.json do
        @records = policy_scope(Variant.for_list)
          .where(variant: { language: I18n.locale })
          .search(
            query: {
              bool: {
                must: {
                  multi_match: {
                    query: params[:q]
                  }
                }
              }
            },
            highlight: {
              fields: {
                'desc': {
                  number_of_fragments: 1,
                  pre_tags: ['<strong>'],
                  post_tags: ['</strong>']
                },
                'comp': {
                  number_of_fragments: 1,
                  pre_tags: ['<strong>'],
                  post_tags: ['</strong>']
                },
                'title_last': {
                  number_of_fragments: 1,
                  pre_tags: ['<strong>'],
                  post_tags: ['</strong>']
                }
              }
            }
          ).records
      end
    end
  end

  private

  def authorize_search
    authorize :search
  end
end
