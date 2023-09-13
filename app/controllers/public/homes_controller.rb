class Public::HomesController < ApplicationController
  def top
    @customer = current_customer
    @post = Post.new
  end
end
