module Spree
  class InstagramPhoto < ActiveRecord::Base
    
    belongs_to :instagram_tag, foreign_key: :tag_id
    
    validates :photo_id, uniqueness: true
    
    default_scope {order('created_time DESC')}
    scope :active, -> { where tag_id: Spree::InstagramTag.active_tag_ids }
    scope :approved, -> { where approved: true,profile: false}
    scope :rejected, -> { where rejected: true,profile: false }
    scope :profile, -> { where profile: true }
    scope :not_rejected, -> { where rejected: false }
    
    def self.fetch_with_tag(tags)
      tags.each do |tag|
        result = HTTParty.get("https://api.instagram.com/v1/tags/#{tag.name}/media/recent?client_id=#{InstagramConfig::CLIENT_ID}")
        if result && result['data']
          result['data'].each do |photo|
            self.create(photo_id: photo['id'], 
                        url: photo['images']['low_resolution']['url'].sub(/http/, 'https'), 
                        tag_id: tag.id,
                        created_time: photo['created_time'])
          end
        end
      end
    end

    def self.fetch_my_photos
        tid = Spree::InstagramTag.where("name='profile'").first.id
        result = HTTParty.get("https://api.instagram.com/v1/users/#{InstagramConfig::USER_ID}/media/recent?client_id=#{InstagramConfig::CLIENT_ID}")
        if result && result['data']
          result['data'].each do |photo|
            self.create(photo_id: photo['id'], 
                        url: photo['images']['low_resolution']['url'].sub(/http/, 'https'), 
                        tag_id: tid,
                        profile: true,
                        created_time: photo['created_time'])
          end
        end
    end
    
    def self.approved_photos
      self.active.approved
    end

    def self.my_photos
      self.profile
    end
    
  end
end
