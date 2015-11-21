class SubsController < ApplicationController
  before_action :require_moderator, only: [:update, :edit]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_path(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = current_sub
    render :edit
  end

  def update
    @sub = current_sub

    if @sub.update(sub_params)
      redirect_to sub_path(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = current_sub
    render :show
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def current_sub
    Sub.find(params[:id])
  end

  def require_moderator
    @sub = current_sub

    unless @sub.is_moderator?(current_user)
      redirect_to sub_path(@sub)
    end
  end
end
