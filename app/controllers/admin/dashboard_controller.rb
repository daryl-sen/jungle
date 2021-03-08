class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  
  def show
    @product_count = Product.count
    @category_count = Category.count
  end

  def new_category

  end

  def create_category
    render plain: params[:post].inspect
  end

  def edit_category

  end

  def delete_category

  end
end
