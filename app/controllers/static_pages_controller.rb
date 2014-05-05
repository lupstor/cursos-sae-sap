class StaticPagesController < ApplicationController
  def home
    unless signed_in?
      redirect_to signin_url
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
