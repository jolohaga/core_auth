module RightsHelper
  def only_ancillary(&block)
    if @right.authorization_type == Right::ANCILLARY
      content_tag(:div, &block)
    end
  end
end