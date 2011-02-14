module MetaApplianceHelper
  def latest_meta_appliance
    site.meta_appliances.appliances.first
  end
end
