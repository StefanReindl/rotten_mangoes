class Movie < ActiveRecord::Base

  has_many :reviews
  mount_uploader :image, ImageUploader

	validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.any?
  end

  def self.filter_by_title(title)
    self.where("movies.title LIKE ?", "%#{title}%")
  end

  def self.filter_by_director(director)
    self.where("movies.director LIKE ?", "%#{director}%")
  end

  def self.filter_by_duration(duration)
    self.where("movies.runtime_in_minutes = ?", "%#{duration}%")
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
  
end
