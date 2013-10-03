module ApplicationHelper
  def sitename_from_header_page
    header_page = Alchemy::Page.find_by_page_layout_and_layoutpage('layout_header', true)
    return "" if header_page.nil?
    page_title = header_page.elements.find_by_name('sitename')
    return "" if page_title.nil?
    page_title.ingredient('name')
  end
end
