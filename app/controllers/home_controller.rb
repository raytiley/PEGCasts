class HomeController < ApplicationController
  def index
    @episodes = Episode.find(:all, :conditions => {:published => true})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @episodes }
    end
  end

end
