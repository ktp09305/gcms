include ActionView::Helpers::TextHelper
Gcms::ExternalsRegistry.register(:request) {|request, controller| Liquor::Rails::Request.new(request, controller) }
Gcms::ExternalsRegistry.register(:index) {|_,_| Gcms::Page.find_by_slug!("index").to_drop }
Gcms::ExternalsRegistry.register(:page) do |request,_|
    page = Gcms::Page.published.find_by_fullpath(request.params[:path] || Gcms::Page::INDEX_FULLPATH)
    unless page # in case of templatable page
      page_path = request.params[:path] || ''
      parent_page_path = File.dirname(page_path)
      parent_page_path = Gcms::Page::INDEX_FULLPATH if parent_page_path == "."
      parent_page = Gcms::Page.published.find_by_fullpath!(parent_page_path)
      templatable_pages = parent_page.children.where(templatable: true)
      page = templatable_pages.detect do |templatable_page|
        templatable_page.fetch_item!(File.basename(page_path))
      end
    end
    page ? page.to_drop : raise(ActiveRecord::RecordNotFound)
end
Gcms::ExternalsRegistry.register(:item) do |request,controller|
  page = Gcms::ExternalsRegistry.externals[:page].call(request, controller)
  if page && page.source.templatable?
    page.source.fetch_item!(File.basename(request.params[:path])).try(:to_drop)
  end
end
Gcms::ExternalsRegistry.register(:search) do |request,controller|
    results = []
    if request.params[:query].present?
        key_words = request.params[:query].split(' ')
        results_ids = Gcms::Page.published.advanced_search(key_words.join('|')).map(&:id)
        results = Gcms::Page.published.where('id IN (?)', results_ids).map {|page| Gcms::SearchItem.new(title: highlight(page.title, key_words, highlighter: '<span class="highlight">\1</span>'), link: page.fullpath, content: highlight(page.content, key_words, highlighter: '<span class="highlight">\1</span>'))}

        Gcms::SearchService.resources.each do |resource|
            resource_ids = resource.advanced_search(request.params[:query].split(' ').join('|')).map(&:id)
            resource_items = resource.where('id IN (?)', resource_ids)
            parent_page = Gcms::Page.published.find_by_templatable_type(resource)
            resource_items.each do |item|
                results << Gcms::SearchItem.new(title: highlight(item.title, key_words, highlighter: '<span class="highlight">\1</span>'), link: parent_page.parent.fullpath + '/' + item.slug, content: highlight(item.content, key_words, highlighter: '<span class="highlight">\1</span>'))
            end if parent_page && parent_page.templatable
        end
    end

    results
end
