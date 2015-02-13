Spree Instagram
==============

A Spree extension for extracting images from your instagram feed and tags.

Based on: [https://github.com/BryceFrye/spree_instagram](https://github.com/BryceFrye/spree_instagram)

Current spree version : 2-4-stable

Installation
------------

Add spree_instagram and httparty to your Gemfile:

```ruby
gem 'httparty'
gem 'spree_instagram', :git => 'https://github.com/fidenz-suchith/spree_instagram.git'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_instagram:install
```

Copy the seed file in to your project and run:

```shell
rake db:seed
```

Set your Instagram client id and user id in initializers/instagram.rb:

```ruby
module InstagramConfig
  CLIENT_ID = "your_client_id'
  USER_ID = "your_user_id'
end
```

An 'Instagram' tab will be added to admin configuration where you can moderate the photos you wish to display.
To get an array of approved photos, simply use the approved_photos method:

```ruby
@photos = Spree::InstagramPhoto.approved_photos
```
Also you can display your instagram feed. 
To get an array of photos in your instagram feed, simply use the below method:

```ruby
@photos = Spree::InstagramPhoto.my_photos
```
