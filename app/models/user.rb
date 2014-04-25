class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }, :default_url => "https://s3-us-west-2.amazonaws.com/slyfoxco/slyfox-avatar.png"

  has_many :posts, dependent: :destroy

  validates :name, presence: true

  def public_params
    {
      id: id,
      name: name,
      location: location,
      avatar_url: avatar.url
    }
  end
end
