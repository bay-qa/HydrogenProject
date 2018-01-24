require 'yaml'

TEST_CONFIG = YAML.load_file('config/configuration.yml')
@success = true

task :cleanup_testout do
  puts "==================== Deleting old reports and logs ====================="
  FileUtils.rm_rf("test_out")
  File.delete("rerun.txt") if File.exist?("rerun.txt")
  File.delete(*Dir.glob("*.html"))
end

namespace :reports do
  task :support_folders do
    puts "==================== Creating report folders for desktop ====================="
    %w(html junit json).each { |dir| FileUtils.mkdir_p("test_out/#{dir}") }
    %w(html junit json).each { |dir| FileUtils.mkdir_p("test_out/rerun/#{dir}") }
  end
end

task :regression, [:tag, :threads] do |t, args|
  Rake::Task["cleanup_testout"].invoke
  Rake::Task["reports:support_folders"].invoke

  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    # Workaround for windows
    # I have not test it on windows, but hopefully its gonna work:)
    system "bundle exec parallel_cucumber -n #{args[:threads]} -o \"-p parallel --tags @#{args[:tag].gsub(" ", ",@")}\" features/ --ignore-tags @not_stable,@dont,@wip "
    if File.exist?("rerun.txt")
      system "bundle exec parallel_cucumber -n #{args[:threads]} -o \"-p parallel_rerun\" "
    end
    @success = true
  else
    # For unix
    sh("if ! bundle exec parallel_cucumber -n #{args[:threads]} -o \"-p parallel --tags @#{args[:tag].gsub(" ", ",@")}\" features/ --ignore-tags @not_stable,@dont,@wip --group-by scenarios
 then
   echo \"-------> tests failed, rerunning\"
   RERUN='RERUN ' bundle exec parallel_cucumber -n #{args[:threads]} -o \"-p parallel_rerun\" --group-by scenarios `cat rerun.txt`
 fi") do |success, _exit_code|
      @success &= success
    end
  end

  raise StandardError, "Tests failed!" unless @success
end
