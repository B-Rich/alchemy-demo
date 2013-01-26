authorization do

  role :demo do
    includes :guest
    has_permission_on :alchemy_pages, :to => [:show] do
      if_attribute :public => true
    end
    has_permission_on :alchemy_admin_users, :to => [:read, :edit]
    has_permission_on :alchemy_admin_dashboard, :to => [:index]
    has_permission_on :alchemy_pictures, :to => [:thumbnail]
    has_permission_on :alchemy_admin_pages, :to => [:index, :fold, :edit_page_content, :link]
    has_permission_on :alchemy_admin_elements, :to => [:manage_elements]
    has_permission_on :alchemy_admin_pictures, :to => [:index, :archive_overlay, :show_in_window]
    has_permission_on :alchemy_admin_attachments, :to => [:index, :archive_overlay, :show, :download]
    has_permission_on :alchemy_admin_contents, :to => [:manage_contents]
    has_permission_on :alchemy_admin_essence_pictures, :to => [:manage_picture_essences]
    has_permission_on :alchemy_admin_essence_files, :to => [:manage_file_essences]
    has_permission_on :alchemy_admin_users, :to => [:index]
    has_permission_on :alchemy_admin_trash, :to => [:index, :clear]
    has_permission_on :alchemy_admin_clipboard, :to => [:index, :insert, :remove, :clear]
    has_permission_on :alchemy_admin_attachments, :to => [:manage]
    has_permission_on :alchemy_admin_pictures, :to => [:manage, :flush]
    has_permission_on :alchemy_admin_pages, :to => [:manage_pages]
    has_permission_on :alchemy_admin_layoutpages, :to => [:index]
    has_permission_on :alchemy_admin_languages, :to => [:manage]
    has_permission_on :alchemy_admin_tags, :to => [:manage]
  end

end
