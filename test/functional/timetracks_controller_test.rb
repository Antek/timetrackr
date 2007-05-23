require File.dirname(__FILE__) + '/../test_helper'
require 'timetracks_controller'

# Re-raise errors caught by the controller.
class TimetracksController; def rescue_action(e) raise e end; end

class TimetracksControllerTest < Test::Unit::TestCase
  fixtures :timetracks

  def setup
    @controller = TimetracksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
