class FeedbackForm < ApplicationForm
  proxy_for Feedback, :@feedback

  HOW_DID_YOU_HEAR_OPTIONS = [
    [ "Word of mouth", "word_of_mouth" ],
    [ "Social media", "social_media" ],
    [ "Email", "email" ],
    [ "Other", "other" ]
  ]

  attribute :name
  attribute :rating, :integer
  attribute :positive_feedback
  attribute :negative_feedback
  attribute :how_did_you_hear
  attribute :how_did_you_hear_other

  attribute :terms_of_service, :boolean

  validates :name, presence: true
  validates :rating, presence: true

  validates :terms_of_service, acceptance: true

  def setup(feedback)
    @feedback = feedback
    self.attributes = feedback.slice(:name, :rating, :positive_feedback, :negative_feedback, :how_did_you_hear, :how_did_you_hear_other)
  end

  def perform
    @feedback.update!(
      name:,
      rating:,
      positive_feedback:,
      negative_feedback:,
      how_did_you_hear:,
      how_did_you_hear_other:
    )
  end

  def display_final_fields?
    rating.present?
  end

  def display_positive_feedback?
    rating.present? && rating >= 8
  end

  def display_negative_feedback?
    rating.present? && rating <= 3
  end

  def display_how_did_you_hear_other?
    how_did_you_hear == "other"
  end

  def disabled?
    terms_of_service != true
  end
end
