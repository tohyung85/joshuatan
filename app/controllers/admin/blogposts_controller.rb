class Admin::BlogpostsController < ApplicationController
  before_action :authenticate_admin!
  def new
    
  end
end
