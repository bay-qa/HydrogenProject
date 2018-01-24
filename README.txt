Requirements:
   - install ruby 2.3.1 or later version(installing with brew is recommended and make it easier )
   - gem install bundler (http://bundler.io/ )
   - bundle (install all gems)

HOW TO RUN TEST:
#from a project directory run the command:
=> USER_NAME= USER_PASSWORD= bundle exec rake regression\["api",10\]

- "api" is a scenario's tag, available tags are ('api', client', 'account', 'model', etc),
    gives flexibility how to create a test suit, if you want to run specific test, feature,
    combination of some features or whole suit.
    For example: api - will run all scenarios, client - only scenarios from client feature file, you can tag some
    scenarios with '@smoke' tag and run those as smoke suit.
    (see examples here: https://github.com/cucumber/cucumber/wiki/Tags )

- "10" is a number of threads for paralel run, can be from 1 up to 50 or even more, depend on
  hardware where tests are running.

- config/configuration.yml can be used to prepare framework for a test run, for now it has only one key-value pair (environment: qa),
   but much more can go into the file if needed, environment: qa, define test environment url:
    ("http://api.#{TEST_CONFIG['environment']}.hydrogenplatform.com:31321/api/v2")
    ("http://api.#{TEST_CONFIG['environment']}.hydrogenplatform.com:31120/hydrogen")

TEST RESULTS:
After test execution is done, HTML, JUNIT(XML) and JSON reports will be created under test_out/ folder.
   - HTML reports is a summary in nice HTML format with all passed and failed scenarios.
   - JUNIT(XML) reports usually used by CI tools like Jenkins for the graphs and analytics representation.
    (https://wiki.jenkins.io/display/JENKINS/JUnit+Plugin)
   - JSON reports is an easiest way to get all information about the test run and test results.
     Can be used by test case management tools like TestRail API's for test result as well.

RERUN failures:
   - framework can rerun failed on first run scenarios and if they passed the exit status will be 'success'.
     it will give one more chance to 'random failure' if there are any. Rerun widely used for UI tests but
     it's also good to have such option in API testing as well.

PARALYZATION:
    - all test can be run in parallel, it will speed up test execution. Depend on hardware, number of threads can vary.
       Minimun recommend number of threads can equal number of cores of your machine.
       For example, running tests in parallel (30 threads) on 2.5 GHz Intel Core i7 machine doesn't give me any problem:)
       but decreasing time of suit run:)
       Test run results:
       Test run 1 thread(without paralization) - 26 scenarios (26 passed), 0m21.643s
       Test run 20 threads(with paralization)  - 26 scenarios (26 passed), 0m4.381s

    - when test suit runs in parallel reports will be generated for each thread(can be combined with custom HTML/XML parser).

Data test generator gem('loren ipsum'):
    - https://github.com/sevenwire/forgery
