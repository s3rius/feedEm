class SearchController < ApplicationController
  def show
  end

  def search
    query = params[:query].to_s.strip
    limit = params[:limit].to_i

    if query.empty?
      @search_result = {res: 'empty_query'}
    else
      limit = 20 if limit < 1

      result = []

      sellers = Seller.search_by_name(query).with_pg_search_rank.limit(limit)

      sellers.each do |seller|
        result << {suggest: seller.name,
                   type: 'Seller',
                   url: (url_for controller: 'sellers', action: 'show', id: seller.id),
                   rank: seller.pg_search_rank}
      end

      merchs = Merchandise.search_by_name(query).with_pg_search_rank.limit(limit)

      merchs.each do |merch|
        seller = merch.seller
        result << {suggest: merch.name,
                   type: 'Order item',
                   url: (url_for controller: 'merchandises', action: 'show', id: merch.id),
                   seller: seller.name,
                   seller_url: (url_for controller: 'sellers', action: 'show', id: seller.id),
                   rank: merch.pg_search_rank}
      end

      result = result.sort_by {|x| x[:rank]}.reverse

      result = {res: 'ok', data: result}

      @search_result = result
    end
  end
end