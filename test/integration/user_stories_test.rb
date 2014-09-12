require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    get "/"
    assert_response :success
    assert_template "index"
    
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success 
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
    
    get "/orders/new"
    assert_response :success
    assert_template "new"
    ship_date_expected = Time.now.to_date  
    post_via_redirect "/orders",
                      order: { name:     "Dave Thomas",
                               address:  "123 The Street",
                               email:    "dave@example.com",
                               payment_type_id: 1,
                               ship_date: Time.now.to_date }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal "Dave Thomas",      order.name
    assert_equal "123 The Street",   order.address
    assert_equal "dave@example.com", order.email
    assert_equal 1,            order.payment_type_id
    assert_equal ship_date_expected, order.ship_date.to_date

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal "Kira <kira@localhost.org>", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
   # Playing time Task H activity 3 - write test for error_notifier
   test "should mail the admin when error occurs" do
    get "/carts/wibble" 
    assert_response :redirect  # should redirect to...
    assert_template "/"        # ...store index

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["kira@localhost.org"], mail.to  ## replace mail id
    assert_equal "Kira <kira@localhost.org>", mail[:from].value  ## replace contact name/mail id
    assert_equal "Depot App Error Reporting", mail.subject
  end
end