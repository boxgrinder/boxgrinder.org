module MetaApplianceHelper
  def latest_meta_appliance
    site.meta_appliances.appliances.each do |appliance|
      return appliance unless appliance[:beta]
    end
  end

  def latest_beta_meta_appliance
    site.meta_appliances.appliances.each do |appliance|
      return appliance if appliance[:beta]
    end

    nil
  end

  def meta_appliances
    appliances = []

    site.meta_appliances.appliances.each do |appliance|
      appliances << appliance unless appliance[:beta]
    end

    appliances
  end
end
