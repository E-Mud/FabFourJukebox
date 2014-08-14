Fabfourjukebox::App.controllers :albums do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :index do
	  @albums = Album.all.map{ |album| AlbumPresenter.new(album) }
	  status 200
	  render 'album/list_album'
  end
  
  get :index, :with => :id do
	  album = Album.get(params[:id].to_i)
	  if album
		  @album = AlbumPresenter.new(album, true)
		  status 200
		  render 'album/album_full'
	  else
		  halt 404
	  end
  end

end 
