class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    #_prototype.html.erbのprototype_path(prototype.id)からprotptypeのidを送っていてそれを受け取っている。:idという記述でいいのは、prototypeコントローラーだからなのかな。
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user.id == current_user.id #unlessはifの逆。falseのときにその処理を実行する
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    #@をつけるのは、更新に失敗して再びeditページに戻るときに、@prototypeを送らないと入力フォームにそのprototypeの情報が反映されないから。
    if @prototype.update(prototype_params)
      redirect_to prototype_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    #active_storageとの関係性もきちんと定義
  end
end
