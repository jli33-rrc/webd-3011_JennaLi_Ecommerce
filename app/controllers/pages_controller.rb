class PagesController < ApplicationController
  layout "public"
  
  def home
  end

  def show
    @page = Page.find_by!(slug: params[:slug])
  end
end
