# Shell
irb = proc do |env|
  ENV['RACK_ENV'] = env
  trap('INT', "IGNORE")
  dir, base = File.split(FileUtils::RUBY)
  cmd = if base.sub!(/\Aruby/, 'irb')
          File.join(dir, base)
        else
          "#{FileUtils::RUBY} -S irb"
        end
  sh "#{cmd} -r ./models/**"
end

desc "Open irb shell in test mode"
task :test_irb do
  irb.call('test')
end

desc "Open irb shell in development mode"
task :dev_irb do
  irb.call('development')
end

desc "Open irb shell in production mode"
task :prod_irb do
  irb.call('production')
end

# Specs
spec = proc do |pattern|
  sh "#{FileUtils::RUBY} -e 'ARGV.each{|f| require f}' #{pattern}"
end

desc "Run all specs"
task default: [:model_spec, :web_spec]

desc "Run model specs"
task :model_spec do
  spec.call('./spec/models/*_spec.rb')
end

desc "Run web specs"
task :web_spec do
  spec.call('./spec/web/*_spec.rb')
end

last_line = __LINE__
# Utils
desc "give the application an appropriate configuration"
task :setup, [:app] do |_, args|
  unless (name = args[:app])
    $stderr.puts "ERROR: Must provide a name argument: example: rake \"setup[App]\""
    exit(1)
  end

  require 'securerandom'
  require 'fileutils'
  lower_name = name.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
  upper_name = lower_name.upcase
  random_bytes = lambda{[SecureRandom.random_bytes(64).gsub("\x00"){((rand*255).to_i+1).chr}].pack('m').inspect}

  File.write('.env.rb', <<END)
when 'test'
  ENV['#{upper_name}_SESSION_SECRET'] ||= #{random_bytes.call}.unpack('m')[0]
  ENV['CONTENTFUL_SPACE_ID'] =''
  ENV['CONTENTFUL_ACCESS_TOKEN'] =''
when 'production'
  ENV['#{upper_name}_SESSION_SECRET'] ||= #{random_bytes.call}.unpack('m')[0]
  ENV['CONTENTFUL_SPACE_ID'] =''
  ENV['CONTENTFUL_ACCESS_TOKEN'] =''
else
  ENV['#{upper_name}_SESSION_SECRET'] ||= #{random_bytes.call}.unpack('m')[0]
  ENV['CONTENTFUL_SPACE_ID'] =''
  ENV['CONTENTFUL_ACCESS_TOKEN'] =''
end
END

  File.write(__FILE__, File.read(__FILE__).split("\n")[0...(last_line-2)].join("\n") << "\n")
end

Rake::Task["default"].clear