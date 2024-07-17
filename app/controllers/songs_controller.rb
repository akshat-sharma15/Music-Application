class SongsController < ApplicationController
  before_action :permit_action, only: [ :update, :delete, :create]
  def allsongs
    songs = Song.all
    if songs
      songs_with_urls = songs.map do |song|
        song.as_json.merge(audio_url: song.audio.attached? ? url_for(song.audio) : nil,poster_url: song.poster.attached? ? url_for(song.poster) : nil)
      end
      render json: songs_with_urls
    else
      render json: { message: "Songs not present" }
    end
  end

  def update
    song = Song.find(params[:id])
    song.update(song_params)
    if song
      render json:song.as_json.merge(audio_url: url_for(song.audio),poster_url: url_for(song.poster))
    else
      render json:song.errors, status: :unprocessable_entity
    end
  end

  def create
    song = Song.create!(song_params)
    if song.present?
      render json: { song: song, song_url: url_for(song.audio),poster_url: url_for(song.poster) }, status: :ok
    else
      render json:song.errors, status: :unprocessable_entity
    end
  end

  def show
    song = Song.find(params[:id])
    if song.audio.attached?
      responce = song.as_json.merge(
        audio_url: url_for(song.audio),
        poster_url: song.poster.attached? ? url_for(song.poster) : nil
      )
      render json:responce
    else
      # render json: song.as_json.merge(audio_url: nil)
      render json: { message: "Songs not present" }
    end
  end

  def delete 
    song = Song.find(params[:id])
    song.destroy
  end

  private
  def song_params
    # debugger
    params.permit(:name,:movie,:lyrics,:audio,:poster,:artist_id)
  end

end
