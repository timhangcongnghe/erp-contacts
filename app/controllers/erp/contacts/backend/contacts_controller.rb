require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class ContactsController < Erp::Backend::BackendController
        before_action :set_contact, only: [:show, :edit, :update, :destroy]
    
        # GET /contacts
        def index
        end
        
        # GET /contacts/1
        # GET /contacts/1.json
        def show
        end
        
        # POST /contacts/list
        def list
          @contacts = Contact.search(params).paginate(:page => params[:page], :per_page => 5)
          
          render layout: nil
        end

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
          @contact.user = current_user
    
          if @contact.save
            if params.to_unsafe_hash['format'] == 'json'
              render json: {
                status: 'success',
                text: @contact.name,
                value: @contact.id
              }              
            else
              redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: 'Contact was successfully created.'
            end            
          else
            render :new
          end
        end

        # PATCH/PUT /contacts/1
        def update
          @contact.user = current_user
          if @contact.update(contact_params)
            if params.to_unsafe_hash['format'] == 'json'
              render json: {
                status: 'success',
                text: @contact.name,
                value: @contact.id
              }              
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
        
        # DELETE /contacts/delete_all
        def delete_all
          @contacts = Contact.where(id: params[:ids])          
          @contacts.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Contacts were successfully destroyed.',
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Contact.dataselect(params[:keyword])
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
            params.fetch(:contact, {}).permit(:name, :title_id, :image_url, :contact_type,
                                              :address_1, :address_2, :city, :zip, :website,
                                              :job_position, :phone, :mobile, :fax, :email,
                                              :birthday, :internal_note, :company_id,
                                              :is_customer, :is_vendor, contact_ids: [])
          end
      end
    end
  end
end
