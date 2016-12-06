Erp::Contacts::Engine.routes.draw do
	namespace :backend, module: "backend", path: "backend/contacts" do
		resources :titles do
			collection do
				put 'archive'
				put 'unarchive'
				post 'list'
				get 'dataselect'
				delete 'delete_all'
				put 'archive_all'
				put 'unarchive_all'
			end
		end
		resources :tags
		resources :contacts do
			collection do
				post 'list'
				get 'dataselect'
				delete 'delete_all'
			end
		end
	end
end