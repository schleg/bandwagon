module TshirtsHelper

  def state_button_label event
    case event
    when :submit
      "Submit for Approval"
    when :reject
      "Reject Tee"
    when :approve
      "Approve Tee"
    when :unpublish
      "Unpublish Tee"
    end
  end
end
