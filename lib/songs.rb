require_relative 'concerns/Concerns.rb'

class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @@all
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def self.new_from_filename(filename)
      parts = filename.split(" - ")
      artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

      artist = Artist.find_or_create_by_name(artist_name)
      genre = Genre.find_or_create_by_name(genre_name)
      self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap {|s| s.save}
  end



end