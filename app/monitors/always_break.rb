# frozen_string_literal: true
class AlwaysBreak < HealthMonitor::Providers::Base
  def check!
    raise "Oh no!"
  end
end
