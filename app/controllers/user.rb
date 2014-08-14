Fabfourjukebox::App.controllers :users do
  include HttpAuthentication::Basic
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
	
	before do
		if request.request_method != 'POST'
			credentials = authenticate_with_http_basic
			halt(401) unless !credentials.nil? && (@requester = User.authenticate(credentials[0], credentials[1]))
		end
	end
	
	error 401 do
		request_http_basic_authentication
	end

	get :index, :provides => [:json, :xml] do
	  @users = User.all.map { |user| UserPresenter.new(user) }
	  status 200
	  render 'user/list_user'
	end
  
	get :index, :with => :id do
		halt(401) unless @requester.id == params[:id].to_i
		@user = UserPresenter.new(@requester, true)
		status 200
		render 'user/user_full'
	end
  
	post :index do
	  request.body.rewind
	  user = User.create(JSON.parse(request.body.read))
	  if user.save
		  headers['Location'] = UserPresenter.new(user).id
		  status 201
	  else
		  status 400
		  @error = user.email.nil? || user.password.nil? ? "email and password must be provided" : "email must be unique"
		  render 'error/bad_request'
	  end
	end

end
