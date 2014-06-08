
def load_config(path)
  path = File.join(Rails.root, path)
  hash = YAML.load(File.read(path)).with_indifferent_access
  hash[Rails.env]
end

# Amazon S3 Settings
AMAZON_CONFIG = load_config('/config/amazon.yml')
