Before do |scenario|
  $test_glob_vars = {}
  $world = self
  # if scenario has tag @dont, do not run the scenario
  if scenario.tags.map(&:name).include? '@dont'
    skip_this_scenario
  end

  puts "TEST STARTED....\n"
end

After do |scenario|
  puts "TEST FINISHED.\n"
  # after each scenario, run this code:
end

at_exit do
#  at the end of the tests execution, run this code:
#   if you ran in parralel, then at the exit of each thread.
  puts "TEST SUIT RUN DONE. BYE-BYE:)\n"
end
