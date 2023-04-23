class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board

  # add
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] || changes[:reset_password_token]}
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

	validates :email, presence: true
  validates :first_name, presence: true, length: {maximum: 255}
	validates :last_name, presence: true, length: {maximum: 255}


  # reset_password_token becomes nil when the password is reset
  # add allow_nil: true to skip validation when the object is nil
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def own?(comment)
  comment.user_id == id
  end


  def bookmark(board)
	bookmark_boards << board
  end

  def unbookmark(board)
	bookmark_boards.destroy(board)
  end

  def bookmark?(board)
	bookmark_boards.include?(board)
  end
end
