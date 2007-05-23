class MembersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create, :show]
  
  # render new.rhtml
  def new
  end
  
  def show
    @member = Member.find(params[:id])
  end

  def create
    @member = Member.new(params[:member])
    @member.save!
    self.current_member = @member
    redirect_to member_path(@member)
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

end
