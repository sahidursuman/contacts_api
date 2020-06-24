class ContactPresenter < BasePresenter
  build_with :id, :name, :email, :avatar, :bio
  
  def avatar
    @object.avatar.url.to_s
  end
end