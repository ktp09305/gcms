module Gcms
  module Permalinkable
    extend ActiveSupport::Concern

    # Entity should respond to "slug"
    def permalink
      templatable_page = Gcms::Page.where(templatable_type: self.class.name).first
      if templatable_page
        Pathname.new(templatable_page.parent.fullpath).join(self.slug.to_s).to_s
      end
    end
  end
end
