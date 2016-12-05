module Erp
  module Contacts
    module Backend
      class TitlesController < Erp::Backend::BackendController
        before_action :set_title, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_titles, only: [:delete_all, :archive_all, :unarchive_all]
    
        # GET /titles
        def index
        end
        
        # POST /titles/list
        def list
          @titles = Title.search(params).paginate(:page => params[:page], :per_page => 3)
          
          render layout: nil
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

          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_titles_path, notice: 'Title was successfully destroyed.' }
            format.json {
              render json: {
                'message': 'Title was successfully destroyed.',
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @title.archive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_titles_path, notice: 'Title was successfully archived.' }
            format.json {
              render json: {
                'message': 'Title was successfully archived.',
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @title.unarchive
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_titles_path, notice: 'Title was successfully unarchive.' }
            format.json {
              render json: {
                'message': 'Title was successfully unarchive.',
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /titles/delete_all?ids=1,2,3
        def delete_all         
          @titles.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Titles were successfully destroyed.',
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /titles/archive_all?ids=1,2,3
        def archive_all         
          @titles.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Titles were successfully archived.',
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /titles/unarchive_all?ids=1,2,3
        def unarchive_all         
          @titles.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'Titles were successfully unarchive.',
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Title.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_title
            @title = Title.find(params[:id])
          end
          
          def set_titles
            @titles = Title.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def title_params
            params.require(:title).permit(:title, :abbreviation)
          end
      end
    end
  end
end
