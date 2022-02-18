# frozen_string_literal: true

# 加载 yml 文件的标准方式
YAML::load_file(File.join(__dir__, '../yetting.yml'))

sidekiq_config = { url: "redis://#{Yetting.redis['password']}@#{Yetting.redis['url']}:6379/0" }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
