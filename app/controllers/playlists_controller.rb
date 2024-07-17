class PlaylistsController < ApplicationController
  before_action :find_playlist, only: [ :update, :delete]
  def all_playlists
    @playlists = @current_user.playlists
    if @playlists
      render json: @playlists
    else
      render json: {message:"playlists empty"}
    end
  end

  def add_songs
    playlist=@current_user.playlists.find_by(id: params[:id])
    unless playlist.present?
      render json: {message:"playlists not present"} and return
    end
    addsong = playlist.playlist_song.create!(song_id:params[:song_id],playlist_id:playlist.id)
    if addsong
      render json: @current_user.playlists
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
      render json:{message:"Update failed"} and return
    end
  end

  def show
    debugger
    @playlist = @current_user.playlists.find_by(id:params[:id])
    unless @playlist
      render json:{message:"Playlists not presents"} ,status: :bad_request
    end
    songs_ids = PlaylistSong.where(playlist_id:@playlist.id).pluck(:song_id).uniq
    songs = Song.where(id: songs_ids)
    
    render json: {playlist: @playlist, songs: songs}, status: :created
    
    # songs_with_urls = songs.map do |song|
    #   song.as_json.merge(audio_url: song.audio.attached? ? url_for(song.audio): nil, poster_url: song.poster.attached? ? url_for(song.poster):nil)
    # end
    # render json: @playlist.as_json.merge(songs: songs_with_urls)
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
    @playlist = @current_user.playlists.find_by(id:params[:id])
    unless @playlist
      render json: { message:"Playlists Not present"}
    end
  end
  def add_songs_params
    params.permit(:song_id)
  end
end
