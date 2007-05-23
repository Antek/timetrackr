class TimetracksController < ApplicationController
  def create
    @member = current_member
    @timetrack = Timetrack.new(params[:timetrack])
    @timetrack.member = @member
    @timetrack.save!
    redirect_to member_path(@member)
  rescue ActiveRecord::RecordInvalid
    render :template => 'members/show'
  end
end