class ListsController < ApplicationController
  def new     #入力画面   #新規投稿、入力、一覧、更新すべてのキーが@list
    @list = List.new
  end         #↑list.html.erbにつながる

  def create  #入力後、投稿ボタンを押した後の動き
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = "投稿に成功しました"
      redirect_to list_path(@list.id)
    else      #new(入力画面)で打たれたものをparamsの判断で許可されたものは、paramsと繋がっているデータベースに入る
      @lists = List.all
      render :new
    end       #許可されなかったときは入力画面に移動する
  end

  def index   #一覧。listジャンルのデータをすべて表示
    @lists = List.all
  end

  def show   #詳細画面。paramsと繋がっているデーターベースから指定したidを探して表示させる
    @list = List.find(params[:id])
  end

  def edit   #編集画面。paramsと繋がっているデーターベースから指定したidを探して表示させる
    @list = List.find(params[:id])
  end

  def update #更新させる。paramsと繋がっているデーターベースから指定したidを探して表示させる。
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end       #paramsに判断させる。

  def destroy     # paramsと繋がっているデーターベースから指定したidを探して表示させる。 # データ（レコード）を削除 # 投稿一覧画面へリダイレクト
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end

private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
          #paramsの中にあるデータから:listジャンルの中のそれぞれ３つに当てはまるところに保存