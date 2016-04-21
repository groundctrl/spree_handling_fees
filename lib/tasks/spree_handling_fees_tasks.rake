namespace :spree do
  namespace :handling_fee do
    desc "Apply current handling fee to all available products"
    task :apply => :environment do
      handling_fee = Spree::Config.handling_fee

      Spree::Variant.update_all(handling_fee: handling_fee)

      puts "All product variants have been updated to use #{handling_fee} as " \
           "the handling fee"
    end
  end
end
