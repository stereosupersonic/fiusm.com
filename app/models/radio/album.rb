class Album
  def initialize(artist_name, song_title)
    @_artist_name = artist_name
    @_song_title  = song_title
    
    raise album_art.inspect
  end
  
  def album_art
    begin
      uri = Amazon::RequestURI.for(Amazon::AWSECommerceService, {
        'Operation'   => 'ItemSearch',
        'SearchIndex' => 'MusicTracks',
        'Keywords'    => 'Pink Floyd - On The Run',
      })

      xml = Nokogiri::XML(open(uri))
      raise xml.to_s
    end
  end
end