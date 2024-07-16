class PlaylistsController < ApplicationController
  before_action :find_playlist, only: [:show, :update, :delete]
  def all_playlists
    @playlists = @current_user.Playlist.all
    if @playlists
      render json: @playlists
    else
      render json: {message:"playlists empty"}
    end
  end

  def create
    # debugger
    @playlist = @current_user.playlists.create(name:params[:name])
    if(@playlist)
      render json:@playlist
    else
      render json: {message:"playlists not created"}
    end
  end

  def update
    if @playlist = Playlist.update(name:params[:name])
      render json:@playlist
    else
      render json:{message:"Update failed"} ,status: :unprocessable_entity
    end
  end

  def show
    songs = @playlist.songs
    songs_with_urls = songs.map do |song|
      song.as_json.merge(audio_url: song.audio.attached? ? url_for(song.audio): nil, poster_url: song.poster.attached? ? url_for(song.poster):nil)
    end
    render json: @playlist.as_json.merge(songs: songs_with_urls)
  end

  def delete
    if @playlist.destroy
      render json: { message:"playlist deleted succesfully"}, status: :ok
    else
      render json: { message:"Failed to delete playlist"}, status: :something_went_wrong
    end
  end
  private
  def find_playlist
    @playlist = @current_user.Playlist.find_by(id:params[:id])
  end
end
