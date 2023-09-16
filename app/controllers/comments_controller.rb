class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype) #別のモデル？であるprototypeのパスにはなるが、指定すれば遷移できるらしい
    else
      @prototype = @comment.prototype #このアクションの最初に@commentを定義しているので@commnetが使える。@commnetはそのcommnetに関連するprototypeのインスタンスを持っているのでそれを取得できるみたい
      @comments = @prototype.comments #対象のprototypeのcommentをすべて取得して@commnetsに入れる
      render "prototypes/show", status: :unprocessable_entity #別ディレクトリのビューファイルを呼び出したい場合は「render "ディレクトリ名/ビューファイル名"」とする
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    #送られたリクエストのURLに「prototype_id」が含まれているので、params[:prototype_id]で取得することができる
    #当たり前だがmergeするのは別テーブルのデータ
  end
end
