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
