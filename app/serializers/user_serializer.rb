class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :country, :email, :created_at, :updated_at

  def name
    "#{object.first_name} #{object.last_name}" # NOTE: could any one of these be empty?
  end
end
