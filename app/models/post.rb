class Post < ActiveRecord::Base
  belongs_to :user

  def user
    super || MissingUser.new
  end
end
