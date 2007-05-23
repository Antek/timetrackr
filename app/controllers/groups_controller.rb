class GroupsController < ApplicationController
  skip_before_filter :login_required, :only => [:create, :index, :show]
  
  def index
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  def create
    @group = Group.create(params[:group])
  end
end