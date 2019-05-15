class Encrypt < ApplicationRecord
  def initialize(attrs_to_manage)
    @attrs_to_manage = attrs_to_manage
  end

  def before_save(model)
    @attrs_to_manage.each do |field|
      model[field].tr!("a-z","b-za")
    end
  end

  def after_save(model)
    @attrs_to_manage.each do |field|
      model[field].tr!("b-za","a-z")
    end
  end

  alias_method :after_find, :after_save
end
