class BasePresenter
  include ActionView::Helpers::NumberHelper
  def initialize(object)
    @object = object
  end

  def self.wrap(objects)
    objects.map { |object| new(object) }
  end

  def method_missing(method, *args, &block)
    @object.send(method, *args, &block)
  end

  def respond_to_missing?(method, include_private = false)
    @object.respond_to?(method, include_private)
  end
end
