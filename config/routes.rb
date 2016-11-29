Erp::Contacts::Engine.routes.draw do
	namespace :backend, module: "backend", path: "backend/contacts" do
		resources :titles do
			collection do
			  post 'list'
			end
		end
		resources :tags
		resources :contacts
	end
end