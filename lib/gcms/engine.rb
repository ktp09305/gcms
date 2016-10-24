require "gcms/dependencies"
require "gcms/search_item"
require 'gcms/drops/page_drop'
require 'gcms/drops/search_item_drop'
require 'gcms/functions/assets'
require 'gcms/functions/currency'
require 'gcms/externals/bigdecimal'
require 'gcms/externals/request'
module Gcms
  class Engine < ::Rails::Engine
    isolate_namespace Gcms

    config.to_prepare do
      ::Devise::SessionsController.layout "gcms/devise"
      ::Devise::RegistrationsController.layout "gcms/devise"
      Dir.glob(Rails.root + "gcms_*/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer "gcms.assets" do |app|
      app.config.less.paths << File.join(Rails.root,'vendor', 'assets', 'bower_components')
      app.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
      app.config.assets.precompile += %w(gcms/application.js gcms/application.css)
      app.config.assets.precompile += %w( Responsive-Dashboard/src/img/** )
      app.config.assets.precompile += %w( **/*.svg **/*.eot **/*.woff **/*.ttf )
      app.config.assets.precompile += %w( ng-ckeditor/libs/ckeditor/** )
    end

    initializer "gcms.compile_templates" do |app|
      app.config.after_initialize do
        Gcms.template_manager = Liquor::Manager.new(import: [Liquor::Pagination, Gcms::Functions::Assets, Gcms::Functions::Currency])

        if ActiveRecord::Base.connection.tables.include?('gcms_templates')
          Template.all.each do |template|
            Gcms.template_manager.register_layout(template.register_id, template.content || "", Gcms::ExternalsRegistry.externals.keys)
          end
        end
        if ActiveRecord::Base.connection.tables.include?('gcms_pages')
          Page.all.each do |page|
            Gcms.template_manager.register_template(page.register_id, page.content || "", Gcms::ExternalsRegistry.externals.keys)
          end
        end
        if ActiveRecord::Base.connection.tables.include?('gcms_snippets')
          Snippet.all.each do |snippet|
            Gcms.template_manager.register_partial(snippet.register_id, snippet.content || "")
          end
        end

        unless Gcms.template_manager.compile
          Gcms.template_manager.errors.each do |error|
            puts error
          end
        end
      end
    end
  end
end
