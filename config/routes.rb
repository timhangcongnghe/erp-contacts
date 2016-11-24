Erp::Contacts::Engine.routes.draw do
	namespace :backend, module: "backend", path: "backend/contacts" do
		resources :titles
	end
end