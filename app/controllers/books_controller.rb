class BooksController < ApplicationController
  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
      # index.htmlに変数を渡すので@bookとなる
    if @book.save
      # 新規投稿が保存された後、リダイレクト先でサクセスメッセージを表示する
      redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
       # renderを使う時は@bookを用いて内容を引っ張ってくること
      @books = Book.all
      render :index
    end
  end

  def show
  	@book = Book.find(params[:id])
  end

  def index
  	@book = Book.new
  	@books = Book.all
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
    if @book.update(book_params)
      # 更新成功後、リダイレクトした先でサクセスメッセージを表示する
  	 redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else
      render :edit
    end

  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
    # 削除後、リダイレクト先でサクセスメッセージを表示する
  	redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
