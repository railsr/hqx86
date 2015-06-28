class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true, uniqueness: true, on: :create, length: {in: 5..150}
  validates :category, presence: true, allow_blank: true
  validates :header_img_url, format: {with: /\.(png|jpg|gif)/, message: "only image url"}, allow_blank: true
  validates :body, presence: true, length: {in: 50..150000}
  
  default_scope {order('created_at DESC')}
  belongs_to :user
  belongs_to :category
  
  private
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end