class Organization < ApplicationRecord
  validates_presence_of :domain, :schema
  validates :schema, uniqueness: true, case_sensitive: false
  after_create :create_tenant
  mount_uploader :logo, PhotoUploader
  private

  def create_tenant
    # Apartment::Tenant.create(self.schema)
  end
end
