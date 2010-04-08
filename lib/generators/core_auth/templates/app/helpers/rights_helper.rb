module RightsHelper
  def only_ancillary(&block)
    if @right.authorization_type == Right::ANCILLARY
      yield
    end
  end
end