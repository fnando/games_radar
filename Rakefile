$LOAD_PATH.unshift "."

require "jeweler"
require "rcov/rcovtask"
require "rake/testtask"
require "hanna/rdoctask"
require "lib/games_radar/version"

Rcov::RcovTask.new do |t|
  t.test_files = FileList["test/**/*_test.rb"]
  t.rcov_opts = ["--sort coverage", "--exclude .renv,.bundle,helper,errors.rb"]

  t.output_dir = "coverage"
  t.libs << "test"
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = "doc"
  rdoc.title = "GamesRadar API"
  rdoc.options += %w[ --line-numbers --inline-source --charset utf-8 ]
  rdoc.rdoc_files.include("README.rdoc", "CHANGELOG.rdoc")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

JEWEL = Jeweler::Tasks.new do |gem|
  gem.name = "games_radar"
  gem.email = "fnando.vieira@gmail.com"
  gem.homepage = "http://github.com/fnando/games_radar"
  gem.authors = ["Nando Vieira"]
  gem.version = GamesRadar::Version::STRING
  gem.summary = "GamesRadar is an API wrapper for the games website http://gamesradar.com"
  gem.description = "GamesRadar is an API wrapper for the games website http://gamesradar.com"
  gem.add_dependency "nokogiri"
  gem.files =  FileList["{README,CHANGELOG}.rdoc", "{lib,test}/**/*"]
  gem.add_development_dependency "jeweler"
  gem.add_development_dependency "rcov"
  gem.add_development_dependency "hanna"
  gem.add_development_dependency "fakeweb"
end

Jeweler::GemcutterTasks.new
