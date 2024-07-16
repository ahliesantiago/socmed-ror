class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  # GET /users/login
  def login
    if !session[:id]
      render "users/login"
    else
      @user = session[:id]
      redirect_to user_path(@user)
    end
  end

  # POST /users/login
  def verify
    user = User.find_by(username: params[:username])
    if user.present? && user.password == params[:password]
      session[:id] = user.id
      session[:username] = user.username
      redirect_to user_url(user.id)
    else
      flash[:alert] = "Invalid username or password"
      redirect_to root_url
    end
  end

  # GET /users/1 or /users/1.json
  def show
    if session[:id]
      @users = User.where.not(id: session[:id]).order(created_at: :desc).limit(5)
      @join_date = @user.created_at.to_time.strftime("%B %d, %Y")
      @following_count = Following.where(user: @user).count
      @follower_count = Following.where(follow: @user).count
      begin
        @following_state = User.find(session[:id]).follows.find(@user.id)
      rescue ActiveRecord::RecordNotFound
        @following_state = "not followed"
      end
      render "users/show"
    else
      redirect_to users_login_path
    end
  end

  # GET /users/new or /register
  def new
    if !session[:id]
      @user = User.new
      render "users/new"
    else
      @user = session[:id]
      redirect_to user_path(@user)
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:id] = @user.id
        session[:username] = @user.username
        format.html { redirect_to user_path(@user), notice: "Hi! Thanks for joining us. Happy learning!" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def logout
    session.clear
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :username, :password)
    end
end
