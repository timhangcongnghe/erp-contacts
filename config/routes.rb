Erp::Contacts::Engine.routes.draw do
	scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/contacts" do
			resources :titles do
				collection do
					post 'list'
					get 'dataselect'
					delete 'delete_all'
					put 'archive'
					put 'unarchive'
					put 'archive_all'
					put 'unarchive_all'
				end
			end
			resources :tags do
				collection do
					post 'list'
					get 'dataselect'
					delete 'delete_all'
					put 'archive'
					put 'unarchive'
					put 'archive_all'
					put 'unarchive_all'
				end
			end
			resources :contacts do
				collection do
					post 'list'
					get 'dataselect'
					delete 'delete_all'
					put 'archive'
					put 'unarchive'
					put 'archive_all'
					put 'unarchive_all'
					get 'export'
				end
				resources :contacts, controller: 'contacts_contacts'
			end
			resources :contact_groups do
				collection do
					post 'list'
					get 'dataselect'
					delete 'delete_all'
					put 'archive'
					put 'unarchive'
					put 'archive_all'
					put 'unarchive_all'
					get 'form_contact_group_condition'
				end
			end
			resources :messages do
				collection do
					post 'list'
				end
			end
		end
	end
end