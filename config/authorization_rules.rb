authorization do
  
  role :demo do
    includes :editor
    has_permission_on :alchemy_admin_users, :to => [:read]
    has_permission_on :alchemy_admin_languages, :to => [:read]
  end
  
end
