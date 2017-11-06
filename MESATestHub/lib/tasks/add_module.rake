namespace :db do
  desc "Add module 'star' to existing Test Cases."
  task :add_star => :environment do
    puts "Updating all #{TestCase.count} test cases."
    TestCase.all.each do |test_case|
      puts "Updating #{test_case.name}"
      test_case.update_attributes module: 'star'
    end
  end

  desc "Add the seven binary test cases to the database."
  task :add_binary => :environment do
    TestCase.create(
      [
        {name: 'star_plus_point_mass', version_added: 10000, module: 'binary'},
        {name: 'star_plus_point_mass_explicit_mdot', version_added: 10000, module: 'binary'},
        {name: 'evolve_both_stars', version_added: 10000, module: 'binary'},
        {name: 'jdot_ml_check', version_added: 10000, module: 'binary'},
        {name: 'jdot_gr_check', version_added: 10000, module: 'binary'},
        {name: 'jdot_ls_check', version_added: 10000, module: 'binary'},
        {name: 'double_bh', version_added: 10000, module: 'binary'}
      ]
    )
  end
end