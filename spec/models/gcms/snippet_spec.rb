require 'spec_helper'

module Gcms
  RSpec.describe Gcms::Snippet, type: :model do
    it "should be registered via ResourceService" do
      expect(Gcms::ResourceService.resources[:content_management][Gcms::Snippet]).to_not be_nil
    end

    it "should be registered as Liquor partial" do
      snippet = FactoryGirl.create(:snippet)
      expect(Gcms.template_manager.fetch_partial(snippet.register_id)).to_not be nil
    end
  end
end
