class LoginController < ApplicationController

  include LoginHelper

  def login   

  end

  def processLogin
  	@userId= params[:UserID]
	  @password = params[:Password]
	  @user = User.find_by_id(@userId)

	if  ( (@user.nil? || @user.Password != @password ) )
        flash[:notice]=  "UserName / Password is wrong."
        redirect_to :action => "login"
	else
        session[:user] = @user
        session[:userid] = @user.id
	    redirect_to :action => "products"
  end

     
  end

  def SignUp
  	@user=User.new
  end

  def products

    if(checkuser)
      @products=Product.all
    else
      redirect_to :action => "login"
    end
  end

  def logout
    session[:userid] =''
    redirect_to :action => "login"
  end

  def signin
  	@first_name=params[:First_Name]
    @last_name=params[:Last_Name] 
    @password=params[:Password]
    @address1=params[:Shipping_Address]
    @city=params[:City]
    @state=params[:State]
    @zip=params[:Zip]

    @user=User.create ({:FirstName =>@first_name, :LastName =>@last_name, :Password =>@password, :ShippingAddress =>@address1, :City =>@city, :State =>@state, :Zip =>@zip})

     if @user.errors.any? # If there are errors, do something
            @user.errors.each do |attribute, message|
                flash[:notice] = message
                redirect_to :action => "SignUp"
            end
      else
            @createdUser  = User.where(:firstName => @first_name , :lastName => @last_name).first
              unless @createdUser.nil?
                 flash[:notice] = "Your Id is"+@createdUser.id.to_s  
                 session[:user] = @createdUser
                 session[:userid]=@createdUser.id
                 redirect_to :action => "products"
              end
      end
  end

   
  def addToCart
      if(checkuser)
                 
          if params[:product].present?
            params[:product].each do |items|        
               @quantityValue= params[:Quantity][items[0]]
               @price= params[:Price][items[0]]
               @existingProduct  = Cart.where(:UserID=> session[:userid] , :ProductID => items[0]).first
                  unless @existingProduct.nil?
                  @existingProduct.update_attribute(:Quantity, @existingProduct.Quantity.to_i+@quantityValue.to_i);
                  else
                    Cart.create({:UserID => session[:userid] , :ProductID => items[0] , :Quantity => @quantityValue, :Price => @price})
                  end  
                 
            end
 redirect_to :action => "products"
          end
      
      else
          redirect_to :action => "login"
      end  
  end  
    

    def viewCart
      if(checkuser)
        @userProducts=  Cart.joins(:Product).where(:UserID => session[:userid]).select("carts.*,  
                                products.*")  
      else
        redirect_to :action => "login"
      end

  end

  def destroy
 
      @cartEntry = Cart.find(params[:id])
      @cartEntry.destroy

      @cartDetails=Cart.where(:UserID=> session[:userid]).first

      respond_to do |format|
         format.html { redirect_to :action => "viewCart" }
         format.js
      end

  end


   def update
      @updateCartEntry = Cart.find(params[:id])
      @updateCartEntry.update_attribute(:Quantity,params[:qty])

 end

def orderDetails
    if(checkuser)
      @cartItems= Cart.where(:UserID => session[:userid])
    
      if  (@cartItems.nil?)
            flash[:notice]=  "You do not have any orders."
      else 
        @cartItems.each do |items|
        @order=Order.create ({:UserID =>items.UserID, :ProductID =>items.ProductID, :Price =>items.Price, :Quantity =>items.Quantity})
      end

        @cartItems.delete_all(:UserID =>session[:userid])
        @orderDetails=Order.where(:UserID => session[:userid])
        @user=session[:user]
        @address=@user.ShippingAddress

      end
    else
      redirect_to :action => "login"
    end
end


end
