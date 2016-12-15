require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class ContactsContactsController < Erp::Backend::BackendController
        before_action :set_contact, only: [:edit, :update, :destroy]
    
        # GET /contacts/new
        def new
          @contact = Contact.new
          @contact.contact_type = params[:contact_type].present? ? params[:contact_type] : Contact::TYPE_PERSON
        end
  
        # GET /contacts/1/edit
        def edit
        end

        # POST /contacts
        def create
          @contact = Contact.new(contact_params)
          @contact.creator = current_user
    
          if @contact.save
            if params.to_unsafe_hash['partial'].present?
              render partial: params.to_unsafe_hash['partial'], locals: {contact: @contact}
            else
              redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: 'Contact was successfully created.'
            end            
          else
            render :new
          end
        end

        # PATCH/PUT /contacts/1
        def update
          if @contact.update(contact_params)
            if params.to_unsafe_hash['partial'].present?
              render partial: params.to_unsafe_hash['partial'], locals: {contact: @contact}
            else
              redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: 'Contact was successfully updated.'
            end            
          else
            render :edit
          end
        end
        
        # DELETE /contacts/1
        def destroy
          @contact.destroy
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Contact was successfully destroyed.',
                'type': 'success'
              }
            }
          end          
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_contact
            @contact = Contact.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def contact_params
            params.fetch(:contact, {}).permit(:name, :title_id, :image_url, :contact_type, :address_1, :address_2, :city, :zip, :website, :job_position, :phone, :mobile, :fax, :email, :birthday, :internal_note, :parent_id, contact_ids: [])
          end
      end
    end
  end
end
