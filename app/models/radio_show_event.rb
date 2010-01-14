class RadioShowEvent

  @@feed = "https://www.google.com/calendar/feeds/fiusm.com_49rh2uc6m857tmte2sme1b721g%40group.calendar.google.com/private-c6c52b9d3e005e649f0a987c0ff92e33/full"
  @@client = GData::Client::Calendar.new
  DEFAULT_QUERY = {
    'orderby' => 'starttime',
    'sortorder' => 'a',
    'singleevents' => true
  }

  attr_accessor :id, :title, :start_time, :end_time

  def ==(event)
    event.id == id
  end
  
  def show
    @show ||= RadioShow.find_by_name(title)
  end

  def initialize(event)
    @id = event.elements['gCal:uid'].attribute('value').value.gsub('@google.com', '')
    @title = event.elements['title'].text
    cuando = event.elements['gd:when']
    @start_time = DateTime.parse(cuando.attribute('startTime').value)
    @end_time   = DateTime.parse(cuando.attribute('endTime').value)
  end
  
  def currently_on?
    DateTime.now >= @start_time && DateTime.now < @end_time
  end

  def self.find(*args)
    options = args.extract_options!

    uri_string = uri(options).to_s
    puts "Querying with: #{uri_string}"
    data = @@client.get(uri_string).to_xml
    data.elements.to_a('entry').collect do |event| 
      self.new(event)
    end
  end
  
  def self.current
    find('start-max' => DateTime.now, :sortorder => :d, 'max-results' => 1).first
  end
  
  def self.upcoming(*args)
    options = args.extract_options!
    options = { :limit => 5 }.merge(options)
    find('start-min' => DateTime.now, 'max-results' => options[:limit])
  end
  
  def self.day(*args)
    options = args.extract_options!
    day = [Date, DateTime].include?(args[0].class) ? args[0] : Date.parse(args[0])
    find('start-min' => day + 4.hours, 'start-max' => day + 1.day + 4.hours)
  end
  
  def self.range(*args)
    find('start-min')
  end
  
  def self.find_up_to(date, options = {})
    options = options.merge({'start-max' => date, 'start-min' => DateTime.now, 'max-results' => 200})
    find(options)
  end

  def self.uri(options = {})
    returning URI::parse(@@feed) do |uri|
      query = URIQuery.new DEFAULT_QUERY
      uri.query = query.merge!(options).to_s
    end
  end

end

class URIQuery < HashWithIndifferentAccess
  def to_s
    to_a.collect { |pair|
      
      pair[1] = pair[1].xmlschema if [DateTime, Date, Time].include?(pair[1].class)
      
      pair.join('=')
    }.join('&')
  end
end
