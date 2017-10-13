# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test_cases = TestCase.create!(
  [
    {
      name: '1M_pre_ms_to_wd',
      version_added: 10000,
      description: 'Evolve a star 1 Msun star from the pre-main sequence all the way to the WD cooling track.',
      datum_1_name: 'steps',
      datum_1_type: 'integer',
      datum_2_name: 'retries',
      datum_2_type: 'integer',
      datum_3_name: 'backups',
      datum_3_type: 'integer'
    },
    {
      name: '15M_thermohaline',
      version_added: 10000,
      description: 'Do something with 15 Msun star and thermhaline mixing.',
      datum_1_name: 'steps',
      datum_1_type: 'integer',
      datum_2_name: 'retries',
      datum_2_type: 'integer',
      datum_3_name: 'backups',
      datum_3_type: 'integer'
    },
    {
      name: 'wd2',
      version_added: 10000,
      description: 'Accrete matter onto a white dwarf so it undergoes several nova flashes and settles into steady hydrogen burning.',
      datum_1_name: 'steps',
      datum_1_type: 'integer',
      datum_2_name: 'retries',
      datum_2_type: 'integer',
      datum_3_name: 'backups',
      datum_3_type: 'integer'
    },
    {
      name: 'wd_ignite',
      version_added: 10000,
      description: 'Blow up a C/O white dwarf, or at least get close.',
      datum_1_name: 'steps',
      datum_1_type: 'integer',
      datum_2_name: 'retries',
      datum_2_type: 'integer',
      datum_3_name: 'backups',
      datum_3_type: 'integer'
    }
  ]
)

computers = Computer.create(
  [
    {
      name: 'compy',
      user: 'Frank Timmes',
      email: 'fxt44@mac.com',
      platform: 'macOS',
      processor: '2.7GHz 12-Core Intel Xeon E5',
      ram_gb: 64,
    },
    {
      name: 'lappy',
      user: 'Bill Wolf',
      email: 'wmwolf@asu.edu',
      platform: 'macOS',
      processor: '3.1GHz Intel Core i7',
      ram_gb: 16,
    },
    {
      name: 'tandy',
      user: 'Josiah Schwab',
      email: 'jwschwab@ucsc.edu',
      platform: 'Arch Linux',
      processor: '3.1GHz Intel Core i7',
      ram_gb: 32,
    },
  ]
)

# populate test instances including a mix of the computers and test cases
# must also build test datum objects to include

####################################
#   instances of 1M_pre_ms_to_wd   #
####################################
instance = TestInstance.create!(
  runtime_seconds: 1500,
  mesa_version: 10000,
  omp_num_threads: 12,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: true,
  test_case_id: test_cases[0].id,
  computer_id: computers[0].id
)
instance.test_data.create(name: 'steps', integer_val: 24000)
instance.test_data.create(name: 'retries', integer_val: 300)
instance.test_data.create(name: 'backups', integer_val: 40)

instance = TestInstance.create(
  runtime_seconds: 2300,
  mesa_version: 10000,
  omp_num_threads: 4,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: true,
  test_case_id: test_cases[0].id,
  computer_id: computers[1].id
)
instance.test_data.create(name: 'steps', integer_val: 24000)
instance.test_data.create(name: 'retries', integer_val: 300)
instance.test_data.create(name: 'backups', integer_val: 40)
 
#####################################
#   instances of 15M_thermohaline   #
#####################################
instance = TestInstance.create(
  runtime_seconds: 600,
  mesa_version: 10000,
  omp_num_threads: 12,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: false,
  test_case_id: test_cases[1].id,
  computer_id: computers[0].id
)
instance.test_data.create(name: 'steps', integer_val: 5000)
instance.test_data.create(name: 'retries', integer_val: 30)
instance.test_data.create(name: 'backups', integer_val: 4)

########################
#   instances of wd2   #
########################
instance = TestInstance.create(
  runtime_seconds: 800,
  mesa_version: 10000,
  omp_num_threads: 12,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: true,
  test_case_id: test_cases[2].id,
  computer_id: computers[0].id
)
instance.test_data.create(name: 'steps', integer_val: 7000)
instance.test_data.create(name: 'retries', integer_val: 100)
instance.test_data.create(name: 'backups', integer_val: 20)

instance = TestInstance.create(
  runtime_seconds: 1200,
  mesa_version: 10000,
  omp_num_threads: 4,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: true,
  test_case_id: test_cases[2].id,
  computer_id: computers[1].id
)
instance.test_data.create(name: 'steps', integer_val: 7000)
instance.test_data.create(name: 'retries', integer_val: 100)
instance.test_data.create(name: 'backups', integer_val: 20)

instance = TestInstance.create(
  runtime_seconds: 900,
  mesa_version: 10000,
  omp_num_threads: 4,
  compiler: 'ifort',
  compiler_version: '17.0',
  platform_version: '10.13',
  passed: false,
  test_case_id: test_cases[2].id,
  computer_id: computers[2].id
)
instance.test_data.create(name: 'steps', integer_val: 7000)
instance.test_data.create(name: 'retries', integer_val: 100)
instance.test_data.create(name: 'backups', integer_val: 20)

##############################
#   instances of wd_ignite   #
##############################
instance = TestInstance.create(
  runtime_seconds: 1200,
  mesa_version: 10000,
  omp_num_threads: 12,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: true,
  test_case_id: test_cases[3].id,
  computer_id: computers[0].id
)
instance.test_data.create(name: 'steps', integer_val: 9000)
instance.test_data.create(name: 'retries', integer_val: 110)
instance.test_data.create(name: 'backups', integer_val: 35)

instance = TestInstance.create(
  runtime_seconds: 2500,
  mesa_version: 9795,
  omp_num_threads: 12,
  compiler: 'gfortran',
  compiler_version: '7.2.0',
  platform_version: '10.13',
  passed: false,
  test_case_id: test_cases[3].id,
  computer_id: computers[0].id
)
instance.test_data.create(name: 'steps', integer_val: 800)
instance.test_data.create(name: 'retries', integer_val: 1000)
instance.test_data.create(name: 'backups', integer_val: 500)
