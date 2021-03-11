class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @email = @order.email
    @ordered_items = LineItem.where("order_id = #{params[:id]}").map{
      |item|
      {
        product: Product.find(item.product_id),
        quantity: item.quantity,
        item_price: item.item_price_cents.to_f / 100,
        total_price: item.total_price_cents.to_f / 100
      }
    }

    @order_total = 0.to_f
    @ordered_items.each do |item|
      @order_total += item[:total_price]
    end
    # raise @order_total.inspect
    # raise @ordered_items.inspect
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end
