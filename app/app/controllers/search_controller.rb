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
        result << {type: 'Seller',
                   rank: seller.pg_search_rank,
                   object: seller}
      end

      merchs = Merchandise.search_by_name(query).with_pg_search_rank.limit(limit)

      merchs.each do |merch|
        seller = merch.seller
        merch_data = merch.attributes
        merch_data[:seller] = seller
        result << {type: 'Order item',
                   rank: merch.pg_search_rank,
                   object: merch_data
                  }
      end

      result = result.sort_by {|x| x[:rank]}.reverse

      result = {res: 'ok', data: result}

      @search_result = result
    end
  end
end
