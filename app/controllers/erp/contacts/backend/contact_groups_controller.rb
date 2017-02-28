module Erp
  module Contacts
    module Backend
      class ContactGroupsController < Erp::Backend::BackendController
        before_action :set_contact_group, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_contact_groups, only: [:delete_all, :archive_all, :unarchive_all]
    
        # GET /contact_groups
        def index
        end
        
        # POST /contact_groups/list
        def list
          @contact_groups = ContactGroup.search(params).paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
        end
    
        # GET /contact_groups/new
        def new
          @contact_group = ContactGroup.new
          @contact_group.contact_group_conditions << ContactGroupCondition.new
        end
    
        # GET /contact_groups/1/edit
        def edit
        end
    
        # POST /contact_groups
        def create
          @contact_group = ContactGroup.new(contact_group_params)
          @contact_group.creator = current_user
          if @contact_group.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @contact_group.name,
                value: @contact_group.id
              }
            else
              redirect_to erp_contacts.edit_backend_contact_group_path(@contact_group), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /contact_groups/1
        def update
          if @contact_group.update(contact_group_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @contact_group.name,
                value: @contact_group.id
              }              
            else
              redirect_to erp_contacts.edit_backend_contact_group_path(@contact_group), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /contact_groups/1
        def destroy
          @contact_group.destroy

          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contact_groups_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @contact_group.archive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contact_groups_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @contact_group.unarchive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_contact_groups_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /contact_groups/delete_all?ids=1,2,3
        def delete_all         
          @contact_groups.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /contact_groups/archive_all?ids=1,2,3
        def archive_all         
          @contact_groups.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /contact_groups/unarchive_all?ids=1,2,3
        def unarchive_all
          @contact_groups.unarchive_all
          
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
              render json: ContactGroup.dataselect(params[:keyword])
            }
          end
        end
        
        def form_contact_group_condition
          @contact_group_condition = ContactGroupCondition.new
          render partial: params[:partial], locals: { contact_group_condition: @contact_group_condition, uid: helpers.unique_id() }
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_contact_group
            @contact_group = ContactGroup.find(params[:id])
          end
          
          def set_contact_groups
            @contact_groups = ContactGroup.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def contact_group_params
            params.fetch(:contact_group, {}).permit(:name, :discount, :discount_type, :note,
                                                    :contact_group_conditions_attributes=>[:id, :name, :operator, :value, :contact_group_id, :_destroy]
                                                    )
          end
      end
    end
  end
end
