class SoupCMSCore

  def self.configure
    yield config
  end

  def self.config
    @@config ||= SoupCMS::Core::Utils::Config.new
  end


end