class MembersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]
  
  # render new.rhtml
  def new
  end
  
  def show
    @member = current_member
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
