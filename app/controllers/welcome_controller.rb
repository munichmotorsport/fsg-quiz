class WelcomeController < ApplicationController
  def index
  end
  
  def make_admin
    if params[:master_password] == "PolenOffen2013!" and current_user.update_attribute :admin, true
      redirect_to "/welcome/index", :notice => "Congratulations, you are now an admin"
    end
  end
end
