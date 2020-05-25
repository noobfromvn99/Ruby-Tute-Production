class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, 
               length: { maximum: 255 },
               format: { with: VALID_EMAIL_REGEX },
               uniqueness: { case_sensitive: false }
    before_save { self.email = self.email.downcase }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def activate
        update_columns(activated: FILL_IN,activated_at: FILL_IN)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    private
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    # Converts email to all lower-case.
    def downcase_email
        self.email = email.downcase
    end
    # Creates and assigns the activation token and digest.
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end
