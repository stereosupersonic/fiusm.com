module Admin::ApplicationHelper

  def form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    options[:builder] = ::FormBuilder
    super(record_or_name_or_array, *(args << options), &proc)
  end

  def fields_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    options[:builder] = ::FormBuilder
    super(record_or_name_or_array, *(args << options), &proc)
  end

  def wide_column
    haml_tag :div, :class => 'wide_column' do
      yield
    end
  end
  
  def side_column
    haml_tag :div, :class => 'side_column' do
      yield
    end
  end
  
  def nice_date(date)
    now = DateTime.now
    now_day  = Date.parse(now.to_s)
    date_day = Date.parse(date.to_s)
    
    # today?
    string = 
      if now_day == date_day
        'Today'
      elsif now_day - 1.day == date_day
        'Yesterday'
      elsif now_day - 7.day < date_day
        date_day.strftime('%A')
      else
        date_day.strftime("%a %m/%d")
      end
    
    string += ' at '
    string += date.strftime('%l:%M %p').gsub(/^0/, '').downcase
  end
  
  def will_paginate(*args)
    capture_haml do
      haml_tag :div, super(*args), :class => 'pagination-wrap'
    end
  end

end