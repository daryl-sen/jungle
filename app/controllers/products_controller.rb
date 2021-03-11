class ProductsController < ApplicationController
  
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    render 'show'
  end

  def sold_out?(product)
    if product.quantity == 0
      return 'sold'
    else
      return 'hidden'
    end
  end

  helper_method :sold_out?

end
