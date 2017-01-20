require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class ContactsController < Erp::Backend::BackendController
        helper Erp::Contacts::Engine.helpers
        
        before_action :set_contact, only: [:archive, :unarchive, :show, :edit, :update, :destroy]
        before_action :set_contacts, only: [:delete_all, :archive_all, :unarchive_all]
        
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
          @contact.creator = current_user
          
          if @contact.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @contact.name,
                value: @contact.id
              }              
            else
              redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: t('.success')
            end            
          else
            puts @contact.errors.to_json
            render :new
          end
        end

        # PATCH/PUT /contacts/1
        def update
          if @contact.update(contact_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @contact.name,
                value: @contact.id
              }              
            else
              redirect_to erp_contacts.edit_backend_contact_path(@contact), notice: t('.success')
            end            
          else
            render :edit
          end
        end

        # DELETE /contacts/1
        def destroy
          @contact.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contacts_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @contact.archive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contact_path(@contact), notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @contact.unarchive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contact_path(@contact), notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
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
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /contacts/archive_all?ids=1,2,3
        def archive_all         
          @contacts.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /contacts/unarchive_all?ids=1,2,3
        def unarchive_all
          @contacts.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Contact.dataselect(params[:keyword], params)
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_contact
            @contact = Contact.find(params[:id])
          end
          
          def set_contacts
            @contacts = Contact.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def contact_params
            params.fetch(:contact, {}).permit(:image_url, :contact_type, :code, :name,
              :company_name, :phone, :address, :tax_code, :birthday,
              :email, :gender, :note, :fax, :website,
              :commission_percent, :archived, :user_id,
              :contact_group_id, :country_id, :state_id, :price_term_id, :tax_id,
              :payment_method_id, :payment_term_id, contact_ids: [], tag_ids: [])
          end
      end
    end
  end
end
