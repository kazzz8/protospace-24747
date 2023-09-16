class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #applicatio_controllerにbefore_actionを使用しているので、すべてのアクションが実行されるまえにこれが実行される。
  #そして、devise_controllerが実行されたときに指定したメソッドが実行される

  private
  def configure_permitted_parameters #このメソッド名はなんでも問題なく動作するが、慣習的にこの名前を使う。
    #deviseをインストールすると、devise_parameter_sanitizerメソッドが使えるようになる。
    #ユーザー登録をする場合に使用することができ、「特定のカラムを許容する」ことのできるメソッド。
    #deviseは予めDBに保存できるカラムが決められている。なのでその他のカラムにレコードを保存するにはこのような設定が必要。
    #:sing_upはdeviseの処理名、keysは許可するキー
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :profile, :occupation, :position])
  end
end
