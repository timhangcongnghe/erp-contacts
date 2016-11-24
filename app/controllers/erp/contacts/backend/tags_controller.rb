require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class TagsController < Erp::Backend::BackendController
        before_action :set_tag, only: [:show, :edit, :update, :destroy]
    
        # GET /tags
        def index
          @tags = Tag.all
        end
    
        # GET /tags/1
        def show
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
          @tag.user = current_user
    
          if @tag.save
            redirect_to erp_contacts.backend_tag_path(@tag), notice: 'Tag was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /tags/1
        def update
          if @tag.update(tag_params)
            redirect_to erp_contacts.backend_tag_path(@tag), notice: 'Tag was successfully updated.'
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
