class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  belongs_to :user
  belongs_to :category

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :category, presence: true

  # Methods
  def self.save_data(params, user = User.new)
    # check new record
    if params[:id].blank?
      @post = self.new params
      @post.user = user
      @post.save if @post.valid?
    else
      # update record
      @post = self.friendly.find params[:id]
      @post.user = user
      @post.update(params)
    end
    @post
  end

  def self.get_all(params)
    self.joins(:category)
      .where("title LIKE ? OR content LIKE ? OR categories.name LIKE ?", 
        "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
      .order(:id)
      .page params[:page]
  end
end
