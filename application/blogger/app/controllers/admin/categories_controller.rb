class Admin::CategoriesController < Admin::ApplicationController
  def index
    @categories = Category.get_all params
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.save_data category_params
    if @category.valid?
      flash[:success] = "Category was successfully created."
      redirect_to admin_categories_path
    else
      flash[:warning] = "Cannot create post, please try again."
      render :new
    end
  end

  def edit
    get_by_id params[:id]
    unless @category
      flash[:warning] = "Category with id #{params[:id]} not found."
      redirect_to admin_categories_path
      return
    end
    render :new
  end

  def update
    @category = Category.save_data category_params
    if @category.valid?
      flash[:success] = "Category was successfully updated."
      redirect_to admin_categories_path
    else
      flash[:warning] = "Cannot update category, please try again."
      render :edit
    end
  end

  def destroy
    get_by_id params[:id]
    if @category.delete
      flash[:success] = "Category was successfully deleted."
    else
      flash[:warning] = "Cannot delete category, please try again."
    end
    redirect_to admin_categories_path
  end

  private 
    def get_by_id(id)
      begin
        @category = Category.find id
      rescue ActiveRecord::RecordNotFound => e
        @category = nil
      end
    end

  private
    def category_params
      params.require(:category).permit(:name, :id)
    end
end
