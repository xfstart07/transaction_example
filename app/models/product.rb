class Product < ApplicationRecord
  has_many :product_photos

  # 数据库中也设置为 null false
  validates :title, presence: true

  # 创建
  def self.create_product
    Product.transaction do
      Product.create!(title: 'fafafa', description: 'fafafefafa', on_demand: true)
    end
  rescue => exception
    Rails.logger.debug(exception.message)
    return false
  end

  # 创建错误时回滚
  def self.create_error_product
    Product.transaction do
      Product.create!(description: 'fafafefafa', on_demand: true)
    end
  rescue => exception
    Rails.logger.debug(exception.message)
    return false
  end

  # 删除
  def self.destroy_product
    Product.transaction do
      Product.first.destroy!
    end
  rescue => exception
    Rails.logger.debug(exception.message)
    return false
  end

  def self.findby_title
    Rails.logger.debug('find_by_title')
    ActiveRecord::Base.transaction do
      product = Product.find_by_title('fafa')

      # 当没有找到记录时，需要手动抛出 ActiveRecord::RecordNotFound 错误
      raise ActiveRecord::RecordNotFound if product.nil?

      product.update!(title: 'fafaees')
    end
  rescue Exception => exception
    Rails.logger.debug(exception.message)
    return false
  end

  def self.find_id
    Rails.logger.debug('find_id')
    ActiveRecord::Base.transaction do
      # 当 find 不到记录时，会抛出错误
      product = Product.find(1)
      product.update!(title: 'fafaees')
    end
  rescue => exception
    Rails.logger.debug(exception.message)
    return false
  end

  def self.product_photo
    ActiveRecord::Base.transaction do
      product = Product.first
      product.update!(title: 'delslss')
      # 当创建失败时，会抛出错误
      product.product_photos.create!
    end
  rescue => e
    Rails.logger.debug(e.message)
    false
  end

  # 嵌套事务
  def self.create_product_photo
    ActiveRecord::Base.transaction do
      product = Product.first
      product.update!(title: 'delslss')

      # 必须设置 requires_new，上层事务才能回滚
      ProductPhoto.transaction(requires_new: true) do
        product.product_photos.create!
      end
    end

  rescue => e
    Rails.logger.debug(e.message)
  end
end
