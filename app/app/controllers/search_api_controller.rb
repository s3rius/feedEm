class SearchApiController < ApplicationController
  def search
    query = params[:query].to_s.strip
    limit = params[:limit].to_i

    if query.empty?
      render json: { res: 'empty_query' }
      return
    end

    limit = 10 if limit < 1

    result = []

    sellers = Seller.search_by_name(query).limit(limit)

    sellers.each do |seller|
      result << { suggest: seller.name,
                  type: 'Seller',
                  url: (url_for controller: 'sellers', action: 'show', id: seller.id) }
    end

    merchs = Merchandise.search_by_name(query).limit(limit)

    merchs.each do |merch|
      result << { suggest: merch.name,
                  type: 'Order item',
                  url: (url_for controller: 'merchandises', action: 'show', id: merch.id) }
    end

    result = { res: 'ok', data: result }

    render json: result
  end
end
