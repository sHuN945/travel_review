class Admin::CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def index
    @customers = Customer.last
    @customers = Customer.page(params[:page]).per(10)
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated customer successfully."
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
