class CategoriesController < ApplicationController

    def index  
        categories = "COALESCE(name, '') LIKE '%'"
        unless params[:q].nil?
            categories = "COALESCE(name, '') LIKE '%" + params[:q] + "%'"
        end
        @categories = Category.where(categories)
    end

    def show
        @category = Category.find(params[:id])
    end 
    
    def new
        @category = Category.new
        @categories = Category.all
    end

    def create
        @category =  Category.new(category_params)
        respond_to do |format|
            if @category.save
                @category.change_state
                format.html { redirect_to categories_path, notice: 'Se ha creado la categoría!'}
            else
                format.html { redirect_to categories_path, notice: 'No se ha creado la categoría'}        
            end
        end
    end

    def edit
        @category = Category.find(params[:id])
        @categories = Category.all
    end
    
    def update
        @category = Category.find(params[:id])
        respond_to do |format|
            if @category.update(category_params)
                @category.change_state
                format.html { redirect_to categories_path, notice: 'Category se ha actualizado!' }
            else
                format.html { redirect_to categories_path, notice: 'La categoría no se ha actualizado' }
            end
        end
    end

    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        respond_to do |format|
            format.html { redirect_to categories_path, notice: 'Se ha borrado al categoría' }
        end
    end    
    
    private
    
    def category_params
        params.require(:category).permit(:name, :category_id, :public_state)
    end
end