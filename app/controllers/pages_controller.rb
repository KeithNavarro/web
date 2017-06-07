# The pages controller contains all of the code for any page inside of /pages
class PagesController < ApplicationController
  
  # back-end code for pages/index
  def index
    #no specific ruby code is needed for this page
  end

  # back-end code for pages/home
  def home
    following = Array.new
    #checks the database for who the user is following.
    for @f in current_user.following do
      following.push(@f.id)
    end
    
    #only posts from users in the following array are collected.
    @posts = Post.all.where("user_id = ?", following)
    @newPost = Post.new
  end

  # back-end code for pages/profile
  def profile
    # grab the username from the URL as :id
    if (User.find_by_username(params[:id]))
      @username = params[:id]
    else 
      # redirect to root
      redirect_to root_path, :notice=> "User not found!" 
    end
    
    #only posts by that specific user are collected from the database
    @posts = Post.all.where("user_id = ?", User.find_by_username(params[:id]).id)
    @newPost = Post.new
  end

  # back-end code for pages/explore
  def explore
    #all posts are collected from the database
    @posts = Post.all
    @newPost = Post.new
  end
end