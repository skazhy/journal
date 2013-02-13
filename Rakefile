require 'aws/s3'

def traverse(dir)
  Dir.foreach(dir) do |entry|
    de = "#{dir}/#{entry}"
    next if [".", ".."].include?
    if File.directory? de
      traverse(de)
    else
      AWS::S3::S3Object.store(de[6..-1], open(de[6..-1]), "karlis.me")
    end
  end
end

desc 'Deploy to S3'
task :deploy do
  # Regenerate before upload
  system 'jekyll'
  system 'compass compile'

  AWS::S3::Base.establish_connection!(
    :access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
    :secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"]
  )
  AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"
  traverse("_site")
end

desc 'Run Jekyll server'
task :server do
  webrick = Process.spawn('jekyll --server')
  compass = Process.spawn('compass watch')

  trap('INT') {
    [webrick, compass].each { |pid| Process.kill(9, pid) rescue Errno::ESRCH }
    exit 0
  }
  [webrick, compass].each { |pid| Process.wait(pid) }
end
