Deface::Override.new(
  :virtual_path => "layouts/erp/backend/_sidebar",
  :name => "add_backend_contacts_link_to_sidebar",
  :insert_after => "[data-erp-hook='sidebar-menu']",
  :partial => "overrides/backend_contacts_link",
  :namespaced => true,
  :original => 'f5fe48b6dc6986328e0b873b3ffa1b228dd52a7c'
)