# frozen_string_literal: true
module ActiveAdmin
  class Engine < ::Rails::Engine
    # Set default values for app_path and load_paths before running initializers
    initializer "active_admin.load_app_path", before: :load_config_initializers do |app|
      ActiveAdmin::Application.setting :app_path, app.root
      ActiveAdmin::Application.setting :load_paths, [File.expand_path("app/admin", app.root)]
    end

    initializer "active_admin.precompile", group: :all do |app|
      ActiveAdmin.application.stylesheets.each do |path, _|
        app.config.assets.precompile << path
      end
      ActiveAdmin.application.javascripts.each do |path, _|
        app.config.assets.precompile << path
      end
    end

    initializer "active_admin.routes" do
      require "active_admin/helpers/routes/url_helpers"
    end

    initializer "active_admin.deprecator" do |app|
      app.deprecators[:activeadmin] = ActiveAdmin.deprecator if app.respond_to?(:deprecators)
    end
  end
end
