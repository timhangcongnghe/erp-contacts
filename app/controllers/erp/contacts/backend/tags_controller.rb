require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class TagsController < Erp::Backend::BackendController
        before_action :set_tag, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_tags, only: [:delete_all, :archive_all, :unarchive_all]
    
        # GET /tags
        def index
        end
    
        # GET /tags/1
        def list
          @tags = Tag.search(params).paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
        end
    
        # GET /tags/new
        def new
          @tag = Tag.new
        end
    
        # GET /tags/1/edit
        def edit
        end
    
        # POST /tags
        def create
          @tag = Tag.new(tag_params)
          @tag.creator = current_user
    
          if @tag.save
            if params.to_unsafe_hash['format'] == 'json'
              render json: {
                status: 'success',
                text: @tag.name,
                value: @tag.id
              }              
            else
              redirect_to erp_contacts.edit_backend_tag_path(@tag), notice: 'Tag was successfully created.'
            end            
          else
            render :new
          end
        end
    
        # PATCH/PUT /tags/1
        def update
          if @tag.update(tag_params)
            redirect_to erp_contacts.edit_backend_tag_path(@tag), notice: 'Tag was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /tags/1
        def destroy
          @tag.destroy
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_tags_path, notice: 'Tag was successfully destroyed.' }
            format.json {
              render json: {
                'message': 'Tag was successfully destroyed.',
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @tag.archive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_tags_path, notice: 'Tag was successfully archived.' }
            format.json {
              render json: {
                'message': 'Tag was successfully archived.',
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @tag.unarchive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_tags_path, notice: 'Tag was successfully active.' }
            format.json {
              render json: {
                'message': 'Tag was successfully active.',
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /tags/delete_all?ids=1,2,3
        def delete_all         
          @tags.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Tags were successfully destroyed.',
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /tags/archive_all?ids=1,2,3
        def archive_all         
          @tags.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Tags were successfully archived.',
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /tags/unarchive_all?ids=1,2,3
        def unarchive_all
          @tags.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Tags were successfully active.',
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Tag.dataselect(params[:keyword], params)
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_tag
            @tag = Tag.find(params[:id])
          end
          
          def set_tags
            @tags = Tag.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def tag_params
            params.fetch(:tag, {}).permit(:name, tag_ids: [])
          end
      end
    end
  end
end
