module Gcms
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../../../../../', __FILE__)

    def copy_initializers
      @source_paths = nil # reset it for the find_in_source_paths method

      Gcms::InstallGenerator.source_root(File.expand_path('../templates', __FILE__))

      template 'devise.rb', 'config/initializers/devise.rb'

      template 'dragonfly.rb', 'config/initializers/dragonfly.rb'

    end

    def insert_engine_routes
      route %(
  mount Gcms::Engine => '/gcms', as: 'gcms'
      )
    end

    def remove_index_html
      remove_file 'public/index.html'
    end

    private

    def generate_secret
      SecureRandom.hex(32)
    end

  end
end
