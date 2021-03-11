class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  
  def show
    @product_count = Product.count
    @category_count = Category.count
    @category_list = Category.all
    # raise @category_list.inspect
  end

  def create_category
    @category = Category.new(category_params)
    @category.save
    render :new_category
  end

  private

  def category_params
    params.require(:post).permit(
      :name
    )
  end
end
