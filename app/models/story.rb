class Story < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
  
  include AASM
    belongs_to :user
    validates :title, presence: true

    default_scope { where(deleted_at: nil)}

    def destroy
      update(deleted_at: Time.now)
    end

    aasm(column: 'status', no_direct_assignment: true) do
      state :draft, initial: true
      state :published
  
      event :publish do
        transitions from: :draft, to: :published
      
        after do
          puts "發簡訊通知"
        end
      end
  
      event :unpublish do
        transitions from: :published, to: :draft
      end
    end

    private
    def slug_candidate
      [
        :title,
        [:title, SecureRandom.hex[0, 8]]
      ]
    end

end