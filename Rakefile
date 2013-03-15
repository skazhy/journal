require 'aws/s3'

S3_BUCKET = "karlis.me"

def upload(path)
  file_key = path[6..-1]
  puts "Uploading #{file_key}"
  AWS::S3::S3Object.store(file_key, open(path), S3_BUCKET, {'x-amz-acl' => 'public-read'})
end

def traverse(root)
  Dir.foreach(root) do |entry|
    next if [".", ".."].include? entry
    path = "#{root}/#{entry}"
    if File.directory? path
      traverse(path)
    else
      upload(path)
    end
  end
end

desc 'Deploy to S3'
task :deploy do
  # Regenerate before upload
  system 'jekyll --no-future > /dev/null'
  system 'compass compile -q'

  AWS::S3::Base.establish_connection!(
    :access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
    :secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"]
  )
  AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"
  traverse("_site")
end

desc 'Run Jekyll server'
task :server do
  webrick = Process.spawn('jekyll --server --auto')
  compass = Process.spawn('compass watch')

  trap('INT') {
    [webrick, compass].each { |pid| Process.kill(9, pid) rescue Errno::ESRCH }
    exit 0
  }
  [webrick, compass].each { |pid| Process.wait(pid) }
end
