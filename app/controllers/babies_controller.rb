class BabiesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @babies = Baby.all
  end

# テスト
  def follow_index
    @babies = Baby.all
    @user = User.find(current_user.id)
    @follow_users = @user.all_following
    @babies = @babies.where(user_id: @follow_users)
  end
# テスト

  def show
  	@baby = Baby.find(params[:id])
    @comment = Comment.new
    @comments = @baby.comments
  end

  def new
  	@baby = Baby.new
  end

  def create
  	baby = Baby.new(baby_params)
  	baby.user_id = current_user.id
  	if baby.save
      tags = Vision.get_image_data(baby.image)#AI追加
      tags.each do |tag|                      #AI追加
        baby.tags.create(name: tag)           #AI追加
      end
      redirect_to baby_path(baby), notice: '投稿に成功しました。'
    else
      render :new
    end
  end

  def edit
    @baby = Baby.find(params[:id])
    if @baby.user != current_user
      redirect_to babies_path, alert: '不正なアクセスです。'
    end
  end

  def update
    baby = Baby.find(params[:id])
    if baby.update(baby_params)
      baby.tags.destroy_all
      tags = Vision.get_image_data(baby.image)#AI追加
      tags.each do |tag|                      #AI追加
        baby.tags.create(name: tag)           #AI追加
      end
      redirect_to baby_path(baby), notice: '投稿を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    baby = Baby.find(params[:id])
    baby.destroy
    redirect_to babies_path
  end

  private
  def baby_params
  	params.require(:baby).permit(:title, :body, :image)
  end
end
