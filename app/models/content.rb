class Content < ApplicationRecord
  belongs_to :user
  def as_json_api
    {
      id: id,
      type: "content",
      attributes: {
        title: title,
        body: body,
        createdAt: created_at.iso8601,
        updatedAt: updated_at.iso8601
      }
    }
  end
end
