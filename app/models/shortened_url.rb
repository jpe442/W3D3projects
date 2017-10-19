class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

    has_many :visits,
      class_name: :Visit,
      primary_key: :id,
      foreign_key: :short_url_id

    has_many :visitors,
      through: :visits,
      source: :visitor

  def self.create!(user, long_url)
    ShortenedUrl.create(short_url: ShortenedUrl.random_code, long_url: long_url, user_id: user.id)
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while exists?(code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def num_clicks
    visits.count
  end

  def num_recent_uniques
  end
end
