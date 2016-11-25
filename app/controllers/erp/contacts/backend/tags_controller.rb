require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class TagsController < Erp::Backend::BackendController
        before_action :set_tag, only: [:show, :edit, :update, :destroy]
        before_action :default_breadcrumb
        
        # add default breadcrumb
        def default_breadcrumb
          add_breadcrumb t('contacts.tag.tags'), erp_contacts.backend_tags_path
        end
    
        # GET /tags
        def index
          @tags = Tag.all.paginate(:page => params[:page], :per_page => 1)
        end
    
        # GET /tags/1
        def show
        end
    
        # GET /tags/new
        def new
          add_breadcrumb t('contacts.tag.create')
          @tag = Tag.new
        end
    
        # GET /tags/1/edit
        def edit
          add_breadcrumb t('contacts.tag.edit')
        end
    
        # POST /tags
        def create
          @tag = Tag.new(tag_params)
          @tag.user = current_user
    
          if @tag.save
            redirect_to erp_contacts.edit_backend_tag_path(@tag), notice: 'Tag was successfully created.'
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
          redirect_to erp_contacts.backend_tags_url, notice: 'Tag was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_tag
            @tag = Tag.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def tag_params
            params.fetch(:tag, {}).permit(:name)
          end
      end
    end
  end
end
