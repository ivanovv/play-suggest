EbaySuggest::Application.routes.draw do
  root 'keywords#new'
  post '/' => 'keywords#create'
end
