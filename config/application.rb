require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module MarugotoBackend
    class Application < Rails::Application

        #config.autoload_paths += Dir[Rails.root.join('app','models','{*/}')]
        config.serve_static_assets = true
        config.assets.precompile += Ckeditor.assets

        config.assets.precompile += %w( ckeditor/my_config.js ckeditor/	my_contents.css ckeditor/filebrowser/*)
        config.assets.paths << Rails.root.join("app", "assets", "fonts")

        #config.autoload_paths += %W( #{config.root}/app/models/ckeditor )

    end
end
