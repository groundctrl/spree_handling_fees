# SpreeHandlingFees

Handling fee per product variant. While [`spree-contrib/spree_handling_fees`](https://github.com/spree-contrib/spree_handling_fees) adds handling fees per shipment, this will add a handling fee per item that is being shipped.

## Installation

#### Gem

Add the following to your Gemfile:

```
gem "spree_handling_fees", github: "groundctrl/spree_handling_fees"
```

#### Generators

Run the bundle command to install it:

```
bundle install
```

After installing, run the generator:

```
bundle exec rails g spree_handling_fees:install
```

## Updating

Copy new migrations

```
rake spree_handling_fees:install:migrations
```

Run migrations

```
rake db:migrate
```

#### Rake

To globally change the current handling fee for all product variants, a Rake task can be run.

The handling fee is not specified here. The handling fee used is the same one that is set in the admin (`/admin/general_settings/edit`).

The handling fee can be accessed using `Spree::Config.handling_fee`.

```
bundle exec rake spree:handling_fee:apply
```

> NOTE: This Rake task does not change the handling fee that was collected on previous orders. It only applies to orders going forward.

## Testing

Run tests. This will also generate the dummy app.

```
bundle exec rake
```

Or take the longer way around

```
bundle exec rake test_app
bundle exec rake spec
```

## TODO

- Display handling fee in checkout with item
- Do not charge handling fee if product is not being shipped
- Allow optional refunding of handling fee during refund/return
  - Allow partial refunding of handling fee

## Contributing

1. Fork it ( https://github.com/groundctrl/spree_handling_fees/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
