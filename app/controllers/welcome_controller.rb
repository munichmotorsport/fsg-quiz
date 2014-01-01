class WelcomeController < ApplicationController
  def index
  end
  
  def make_admin
    if params[:master_password] == 'PolenOffen2014!' and current_user.update_attribute :admin, true
      redirect_to "/welcome/index", :notice => 'With great power comes great responsibility.'
    end
  end
end
