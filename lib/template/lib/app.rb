require './lib/config'

class SinatraApp
  helpers do
  end

  get '/' do
    haml :index
  end
end
