Rabl.configure do |config|
  config.cache_all_output = true
  config.cache_sources = Padrino.env.to_s != 'development' # Defaults to false
  config.view_paths = [Padrino.root.join("app/templates")]
end 
