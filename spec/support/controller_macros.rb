module ControllerMacros
  def login_user(user=nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user ||= FactoryBot.build(:user)
    sign_in user
  end
end