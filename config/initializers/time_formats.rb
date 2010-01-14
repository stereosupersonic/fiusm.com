Time::DATE_FORMATS.merge!({
  :formal_date => lambda { |date| date.strftime("%B #{date.day.ordinalize}, %Y") }
})