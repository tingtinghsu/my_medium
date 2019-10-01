class StoriesController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :find_story, only: [:edit, :update, :destoy]

  def index
    @stories = current_user.stories.order(updated_at: :desc)
  end
  def new
    #@story = Story.new
    @story = current_user.stories.new
  end
  def create
    @story = current_user.stories.new(story_params)
    if @story.save
     redirect_to stories_path, notice: '新增成功'
    else
      render :new
    end
  end

  
  def edit
    
  end

  def update
    if @story.update(story_params)
      redirect_to stories_path, notice: '故事更新成功！'
    else
      render :edit
    end
  end

  def destoy
    
  end
  private
  def story_params
    params.require(:story).permit(:title, :content)
  end

  def find_story
    @story = current_user.stories.find(params[:id])
  end
end
