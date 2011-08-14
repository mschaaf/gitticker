class HttpAuth

  def auth(user, password)
    @user=user
    @password=password
  end

  def user
    @user
  end

  def password
    @password
  end

  def isSet
    !(@user.nil? && @password.nil?)
  end

end