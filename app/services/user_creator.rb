class UserCreator
  def create_user(signup)
    User.create({ :email => signup.email, :imdb => signup.imdb, :website => signup.website })
  end
end