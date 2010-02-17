require "rcov/rcovtask"
require "rake/testtask"
require "hanna/rdoctask"

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
