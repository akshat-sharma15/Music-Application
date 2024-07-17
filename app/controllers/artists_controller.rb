class ArtistsController < ApplicationController
  before_action :permit_action, only: [:update, :create, :delete]
  before_action:find_artist ,only: [:show, :update, :delete]
  def artistss
    artists = Artist.all
    render json:artists
  end

  def create
    artist = Artist.new(artist_params)
    if artist.save
      render json: artist, status: :created
    else
      render json:artist.errors ,status: :unprocessable_entity
    end
  end

  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json:{message:"Update failed"} ,status: :unprocessable_entity
    end
  end
  
  def show
    if @artist.present? 
      songs = @artist.songs
      songs_with_urls = songs.map do |song|
        song.as_json.merge(audio_url: song.audio.attached? ? url_for(song.audio) : nil,poster_url: song.poster.attached? ? url_for(song.poster) : nil)
      end
      render json: @artist.as_json.merge(songs: songs_with_urls)
    else
      render json: { message:"Artist Not present"}, status: :bad_request
    end
  end

  def delete
    if @artist.destroy
      render json: { message:"Artist deleted succesfully"}, status: :ok
    else
      render json: { message:"Failed to delete Artist"}, status: :ok
    end
  end

  private
  def artist_params
    params.permit(:name, :display_pic)
  end
  def find_artist
    @artist = Artist.find_by(id:params[:id])
  end
end
