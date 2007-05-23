class GroupsController < ApplicationController
  skip_before_filter :login_required, :only => [:create]
  
  def create
    @group = Group.create(params[:group])
  end
end