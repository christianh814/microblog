class MicropostsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      ##
      # Check to see if it's an @reply
      ##
      if @micropost.content =~ /(@)\S+/i
        @user = @micropost.content.match(/(@)\S+/i).to_s.gsub(/(@)/, '')
        if User.search(@user).empty?
          @micropost.in_reply_to = nil
	else
          @user = User.find_by(:username => @user)
          @micropost.in_reply_to = @user.id
          @micropost.save
        end
      end
      ##
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
