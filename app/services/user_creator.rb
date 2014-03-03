class UserCreator
  def create_user(signup, skills)  
    @user = User.create({ :email => signup.email, :imdb => signup.imdb, :website => signup.website })
    skills.reject!(&:blank?)
    
    if @user && @user.errors.count == 0
      skills.each do |skill_id|
        UserSkill.create!({ :user_id => @user.id, :skill_id => skill_id.to_i })
      end
    end
    
    @user
  end
end