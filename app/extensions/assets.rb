require 'sprockets'
require 'stylus/sprockets'

module Personal
  module Extensions
    module Assets extend self
      class UnknownAsset < StandardError; end

      module Helpers
        def asset_path(name)
          asset = settings.assets[name]
          raise UnknownAsset, "Unknown asset: #{name}" unless asset
          "#{settings.asset_host}/assets/#{asset.digest_path}"
        end
      end

      def registered(app)
        # Assets
        app.set :assets, assets = Sprockets::Environment.new(app.settings.root)

        assets.append_path('app/assets/js')
        assets.append_path('app/assets/css')
        assets.append_path('app/assets/img')
        assets.append_path('app/assets/font')

        Stylus.setup(assets)

        app.set :asset_host, ''

        assets.cache = Sprockets::Cache::FileStore.new('./tmp')

        app.helpers Helpers
      end
    end
  end
end