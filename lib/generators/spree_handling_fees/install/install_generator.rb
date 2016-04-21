module SpreeHandlingFees
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        %w(frontend backend).each do |section|
          append_file "vendor/assets/javascripts/spree/#{section}/all.js",
                      "//= require spree/#{section}/spree_handling_fees\n "
        end
      end

      def add_stylesheets
        %w(frontend backend).each do |section|
          inject_into_file "vendor/assets/stylesheets/spree/#{section}/all.css",
                           " *= require spree/#{section}/spree_handling_fees\n",
                           before: %r{\*/},
                           verbose: true
        end
      end

      def add_migrations
        run "bundle exec rake railties:install:migrations "\
            "FROM=spree_handling_fees"
      end

      def run_migrations
        migration_message = "Would you like to run the migrations now? [Y/n]"

        run_migrations = options[:auto_run_migrations] || ["", "y", "Y"]
                         .include?(ask(migration_message))

        if run_migrations
          run "bundle exec rake db:migrate"
        else
          puts "Skipping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end
