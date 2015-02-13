module Spree
  module Admin
    class InstagramPhotosController < Spree::Admin::ResourceController
      
      def index
        @photos = Spree::InstagramPhoto.active.not_rejected
      end

      def approved
        @photos = Spree::InstagramPhoto.active.approved
      end

      def profile
        @photos = Spree::InstagramPhoto.profile
      end
      
      def rejected
        @photos = Spree::InstagramPhoto.active.rejected
      end
      
      def check_for_new
        Spree::InstagramPhoto.fetch_with_tag(Spree::InstagramTag.active_tags)
        redirect_to admin_instagram_photos_path
      end

      def check_my_photos
        Spree::InstagramPhoto.fetch_my_photos
        redirect_to admin_profile_photos_path
      end
 
      def instagram_photo_params
    	params.require(:instagram_photo).permit(:photo_id, :url, :tag_id, :approved, :rejected, :created_time)
      end
      
    end
  end
end
