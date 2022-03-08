
module HasGenericScopes
  extend ActiveSupport::Concern

  module ClassMethods
    def generate_default_ilike_scopes(*fields)
      fields.each do |field|
        scope "with_#{field}", -> (param) { where("#{field} ILIKE :value", value: "%#{param}%")}
      end
    end

    def generate_default_numeric_scopes(*fields)
      fields.each do |field|
        scope "with_#{field}_max", -> (param) { where("#{field} <= #{param}")}
        scope "with_#{field}_min", -> (param) { where("#{field} >= #{param}")}
      end
    end
  end
end
