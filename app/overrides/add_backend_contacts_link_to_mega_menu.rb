Deface::Override.new(
  :virtual_path => "layouts/erp/backend/_mega_menu",
  :name => "add_backend_contacts_link_to_mega_menu",
  :insert_after => "[data-erp-hook='mega-menu']",
  :partial => "overrides/backend_contacts_link_to_mega_menu",
  :namespaced => true,
  :original => 'f5fe48b6dc6986328e0b873b3ffa1b228dd52a7c'
)