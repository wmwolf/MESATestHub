# convert ALL current test cases to star module
TestCase.all.each { |test_case| test_case.update_attributes module: 'star' }

# add binary test_cases
TestCase.create (
  [
    {name: 'star_plus_point_mass', version_added: 10000, module: 'binary'},
    {name: 'star_plus_point_mass_explicit_mdot', version_added: 10000, module: 'binary'},
    {name: 'evolve_both_stars', version_added: 10000, module: 'binary'},
    {name: 'jdot_ml_check', version_added: 10000, module: 'binary'},
    {name: 'jdot_gr_check', version_added: 10000, module: 'binary'},
    {name: 'jdot_ls_check', version_added: 10000, module: 'binary'},
    {name: 'double_bh', version_added: 10000, module: 'binary'},