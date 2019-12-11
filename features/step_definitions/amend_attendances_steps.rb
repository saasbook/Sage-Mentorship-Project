Then(/^I pick "(.*)" in the datetime_select box labeled "(.*)"$/) do |datetime_box_value, datetime_box_label|
  year, month, day, hour, minute = datetime_box_value.match(/^(\d+)\-(\d+)\-(\d+) (\d+):(\d+)$/).captures
  month = Date::MONTHNAMES[month.to_i]

  label = page.find('label', text: datetime_box_label)
  id = label['for']

  select year,   from: "#{id}_1i"
  select month,  from: "#{id}_2i"
  select day,    from: "#{id}_3i"
  select hour,   from: "#{id}_4i"
  select minute, from: "#{id}_5i"
end

