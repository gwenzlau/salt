class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "https://s3-us-west-2.amazonaws.com/slyfoxco/slyfox-avatar.png"
  
validates_attachment_content_type :avatar, :content_type => /\Aimage/
# Validate filename
#validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
# Explicitly do not validate
#do_not_validate_attachment_file_type :avatar

  has_many :posts, dependent: :destroy

  validates :name, presence: true

  def public_params
    {
      id: id,
      name: name,
      location: location,
      avatar: avatar
    }
  end
end
