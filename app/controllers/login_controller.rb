class LoginController < ApplicationController

  def login   

  end

  def processLogin
  	  @userId= params[:UserID]
	  @password = params[:Password]
	  @user = User.find_by_id(@userId)

	if  ( (@user.nil? || @user.Password != @password ) )
        flash[:notice]=  "User Name/Password is wrong"
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
    @products=Product.all
  end



  def signin
  	@first_name=params[:First_Name]
    @last_name=params[:Last_Name]
    @password=params[:Password]
    @address1=params[:ShippingAddress]
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
                 redirect_to :action => "products"
              end
      end
  end

   
   def addToCart
       @products= Product.all
       @user = session[:user]  
    if params[:product].present?
      params[:product].each do |items|        
       @quantityValue= params[:Quantity][items[0]]
       @existingProduct  = Cart.where(:UserID=> @user.id , :ProductID => items[0]).first
            unless @existingProduct.nil?
            @existingProduct.update_attribute(:Quantity, @existingProduct.Quantity.to_i+@quantityValue.to_i);
            else
            Cart.create({:UserID => @user.id , :ProductID => items[0] , :Quantity => @quantityValue})
            end  
     end
end  
  
  render 'login/products'

  end

    def viewCart
      @user = session[:user]
      @userProducts=  Cart.joins(:Product).where(:UserID => @user.id).select("carts.*,  
                                products.*")  


  end

  def destroy
 
      @cartEntry = Cart.find(params[:id])
      @cartEntry.destroy

      respond_to do |format|
         format.html { redirect_to :action => "viewCart" }
         format.js
      end

  end

end
