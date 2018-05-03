# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
  has_many :visits, 
    primary_key: :id, 
    foreign_key: :shortened_url_id,
    class_name: :Visit 
    
  # has_many :visitors, through: :visits, source: :user
  
  has_many :visitors,
   Proc.new { distinct }, #<<<
   through: :visits,
   source: :user
  
  def self.random_code
    loop do 
      short_url = SecureRandom.urlsafe_base64(16)
      return short_url unless ShortenedUrl.exists?(short_url: short_url)
    end
  end 
  
  def self.create_shortened_url(user, long_url) 
    new_short = ShortenedUrl.new(long_url: long_url, user_id: user.id, short_url: ShortenedUrl.random_code)
    new_short.save 
  end
  
  def num_clicks
    self.visits.length
  end
  
  def num_uniques
    # self.visits.map(&:id).uniq.length
    self.visitors.length
  end
  
  def num_recent_uniques
    count = 0
    
    self.visits.each do |visit|
      count += 1 if (Time.now.to_i - User.created_at.to_i) <= 10
    end
    count
  end
end
