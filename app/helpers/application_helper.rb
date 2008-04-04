# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def pie_chart_for_member_for_week(member, week)
    used_labels = member.used_labels_for_week(week)
    unless used_labels.empty?
      %{<img src="#{member.timetracks.pie_chart_url_for_week_with_labels(week, @member.used_labels_for_week(week))}" />}
    end
  end
  
  def line_chart_for_group(group)
    GoogleChart::LineChart.new('600x300', "uren per week per persoon", false) do |lc|
      weeks = group.timetracks.weeks
      max_per_members = []
      
      group.members.each do |member|
        line_data = weeks.collect { |week| member.timetracks.total_hours_in_week(week) }
        lc.data member.fullname, line_data, line_color(member.id)
        max_per_members << line_data.max
      end
            
      lc.show_legend = true
      lc.axis :x, :range => [weeks.first, weeks.last]
      lc.axis :y, :range => [0, max_per_members.max]
      
      return %{<img src="#{lc.to_url}" />}
    end
  end
  
  private
  def line_color(id = rand(15))
    colors = []
    colors = (15), (id % 16), (id*3 % 16)
    colors.map { |c| c.to_s(16) + c.to_s(16) }.join('')
  end
end
