class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]

    def format_number(num_string)
      num_string = num_string.to_f / 100
      thousands = (num_string / 1000).to_i
      if thousands != 0
        return thousands + ',' + num_string
      end
      return num_string
    end

    # @product.price = format_number(@product.price)

    render 'show'
  end

end
