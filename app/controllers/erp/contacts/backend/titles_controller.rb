require_dependency "erp/application_controller"

module Erp
  module Contacts
    module Backend
      class TitlesController < Erp::Backend::BackendController
        before_action :set_title, only: [:show, :edit, :update, :destroy]
    
        # GET /titles
        def index
          @titles = Title.all
        end
    
        # GET /titles/1
        def show
        end
    
        # GET /titles/new
        def new
          @title = Title.new
        end
    
        # GET /titles/1/edit
        def edit
        end
    
        # POST /titles
        def create
          @title = Title.new(title_params)
          @title.user = current_user
    
          if @title.save
            redirect_to erp_contacts.edit_backend_title_path(@title), notice: 'Title was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /titles/1
        def update
          if @title.update(title_params)
            redirect_to erp_contacts.edit_backend_title_path(@title), notice: 'Title was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /titles/1
        def destroy
          @title.destroy
          redirect_to erp_contacts.backend_titles_url, notice: 'Title was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_title
            @title = Title.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def title_params
            params.require(:title).permit(:title, :abbreviation)
          end
      end
    end
  end
end
