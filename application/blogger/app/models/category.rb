class Category < ActiveRecord::Base
  # Associations
  has_many :posts, dependent: :destroy

  # Validations
  validates :name, presence: true

  # Methods
  def self.save_data(params)
    # check new record
    if params[:id].blank?
      @category = self.new params
      @category.save if @category.valid?
    else
      # update record
      @category = self.find params[:id]
      @category.update(params)
    end
    @category
  end

  def self.get_all(params)
    self.where("name LIKE ?", "%#{params[:q]}%").order(:id).page params[:page]
  end
end
