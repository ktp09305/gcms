require 'spec_helper'

describe Gcms::HelpService, type: :service do
  it "should register help partials" do
    Gcms::HelpService.register_templates Gcms::Engine, 'gcms_help.html'
    expect(Gcms::HelpService.templates[Gcms::Engine]).to include 'gcms_help.html'
  end
end
