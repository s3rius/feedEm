class SearchApiController < ApplicationController
  def search
    query = params[:query].to_s.strip
    limit = params[:limit].to_i

    if query.empty? then
      render :json => {:res => 'empty_query'}
      return
    end

    if limit < 1 then
      limit = 10
    end

    result = []

    sellers_names = Seller.search_by_name(query).map(&:name)

    sellers_names.each { |name|
      result << {:suggest => name, :type => 'Seller'}
    }

    merch_names = Merchandise.search_by_name(query).map(&:name)

    merch_names.each { |name|
      result << {:suggest => name, :type => 'Order item'}
    }

    result = {:res => 'ok', :data => result}

    render :json => result
  end
end
