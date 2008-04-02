# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def pie_chart_for_member_for_week(member, week)
    used_labels = member.used_labels_for_week(week)
    unless used_labels.empty?
      %{<img src="#{member.timetracks.pie_chart_url_for_week_with_labels(week, @member.used_labels_for_week(week))}" />}
    end
  end
end
