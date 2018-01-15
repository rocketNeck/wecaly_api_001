class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  #init a AuthenticateUser class with email and password
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebtoken.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'Invalid credentials'
    nil
  end
end