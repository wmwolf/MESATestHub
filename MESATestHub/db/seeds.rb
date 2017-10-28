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
      name: '1.5M_with_diffusion',
      version_added: 10000,
    },
    {
      name: '15M_dynamo',
      version_added: 10000,
    },
    {
      name: '1M_pre_ms_to_wd',
      version_added: 10000,
    },
    {
      name: '1M_pre_ms_to_wd_part2',
      version_added: 10000,
    },
    {
      name: '1M_thermohaline',
      version_added: 10000,
    },
    {
      name: '1M_thermohaline_split_mix',
      version_added: 10000,
    },
    {
      name: '20M_si_burn_qp_bcyclic',
      version_added: 10000,
    },
    {
      name: '20M_si_burn_split_mix',
      version_added: 10000,
    },
    {
      name: '25M_z2m2_high_rotation',
      version_added: 10000,
    },
    {
      name: '30M_big_net',
      version_added: 10000,
    },
    {
      name: '30M_core_collapse_big_net',
      version_added: 10000,
    },
    {
      name: '30M_logT_9.8_big_net',
      version_added: 10000,
    },
    {
      name: '7M_prems_to_AGB',
      version_added: 10000,
    },
    {
      name: '8.8M_urca',
      version_added: 10000,
    },
    {
      name: 'accreted_material_j',
      version_added: 10000,
    },
    {
      name: 'accretion_with_diffusion',
      version_added: 10000,
    },
    {
      name: 'adjust_net',
      version_added: 10000,
    },
    {
      name: 'agb',
      version_added: 10000,
    },
    {
      name: 'agb_to_wd',
      version_added: 10000,
    },
    {
      name: 'axion_cooling',
      version_added: 10000,
    },
    {
      name: 'black_hole',
      version_added: 10000,
    },
    {
      name: 'black_hole_part2',
      version_added: 10000,
    },
    {
      name: 'brown_dwarf',
      version_added: 10000,
    },
    {
      name: 'c13_pocket',
      version_added: 10000,
    },
    {
      name: 'cburn_inward',
      version_added: 10000,
    },
    {
      name: 'check_vlm_models',
      version_added: 10000,
    },
    {
      name: 'check_wd_models',
      version_added: 10000,
    },
    {
      name: 'conductive_flame',
      version_added: 10000,
    },
    {
      name: 'conserve_angular_momentum',
      version_added: 10000,
    },
    {
      name: 'cool_brown_dwarf',
      version_added: 10000,
    },
    {
      name: 'create_zahb',
      version_added: 10000,
    },
    {
      name: 'create_zams',
      version_added: 10000,
    },
    {
      name: 'custom_colors',
      version_added: 10000,
    },
    {
      name: 'custom_rates',
      version_added: 10000,
    },
    {
      name: 'det_riemann',
      version_added: 10000,
    },
    {
      name: 'diffusion_smoothness',
      version_added: 10000,
    },
    {
      name: 'envelope_inflation',
      version_added: 10000,
    },
    {
      name: 'example_astero',
      version_added: 10000,
    },
    {
      name: 'example_ccsn_IIp',
      version_added: 10000,
    },
    {
      name: 'example_ccsn_IIp_partB',
      version_added: 10000,
    },
    {
      name: 'example_ccsn_IIp_partC',
      version_added: 10000,
    },
    {
      name: 'example_make_pre_ccsn',
      version_added: 10000,
    },
    {
      name: 'example_solar_model',
      version_added: 10000,
    },
    {
      name: 'example_solar_model_part2',
      version_added: 10000,
    },
    {
      name: 'hb_2M',
      version_added: 10000,
    },
    {
      name: 'he_core_flash',
      version_added: 10000,
    },
    {
      name: 'high_mass',
      version_added: 10000,
    },
    {
      name: 'hot_cool_wind',
      version_added: 10000,
    },
    {
      name: 'hse_riemann',
      version_added: 10000,
    },
    {
      name: 'irradiated_planet',
      version_added: 10000,
    },
    {
      name: 'low_z',
      version_added: 10000,
    },
    {
      name: 'make_co_wd',
      version_added: 10000,
    },
    {
      name: 'make_he_wd',
      version_added: 10000,
    },
    {
      name: 'make_metals',
      version_added: 10000,
    },
    {
      name: 'make_o_ne_wd',
      version_added: 10000,
    },
    {
      name: 'make_sdb',
      version_added: 10000,
    },
    {
      name: 'multimass',
      version_added: 10000,
    },
    {
      name: 'multiple_stars',
      version_added: 10000,
    },
    {
      name: 'neutron_star_envelope',
      version_added: 10000,
    },
    {
      name: 'noh_riemann',
      version_added: 10000,
    },
    {
      name: 'nova',
      version_added: 10000,
    },
    {
      name: 'ns_c',
      version_added: 10000,
    },
    {
      name: 'ns_h',
      version_added: 10000,
    },
    {
      name: 'ns_he',
      version_added: 10000,
    },
    {
      name: 'other_physics_hooks',
      version_added: 10000,
    },
    {
      name: 'ppisn',
      version_added: 10000,
    },
    {
      name: 'pre_zahb',
      version_added: 10000,
    },
    {
      name: 'pulse_adipls',
      version_added: 10000,
    },
    {
      name: 'pulse_gyre',
      version_added: 10000,
    },
    {
      name: 'relax_composition_j_entropy',
      version_added: 10000,
    },
    {
      name: 'sample_he_zams',
      version_added: 10000,
    },
    {
      name: 'sample_pre_ms',
      version_added: 10000,
    },
    {
      name: 'sample_zams',
      version_added: 10000,
    },
    {
      name: 'semiconvection',
      version_added: 10000,
    },
    {
      name: 'semiconvection_split_mix',
      version_added: 10000,
    },
    {
      name: 'sewind',
      version_added: 10000,
    },
    {
      name: 'surface_effects',
      version_added: 10000,
    },
    {
      name: 'timing',
      version_added: 10000,
    },
    {
      name: 'very_low_mass',
      version_added: 10000,
    },
    {
      name: 'wd',
      version_added: 10000,
    },
    {
      name: 'wd2',
      version_added: 10000,
    },
    {
      name: 'wd3',
      version_added: 10000,
    },
    {
      name: 'wd_acc_small_dm',
      version_added: 10000,
    },
    {
      name: 'wd_aic',
      version_added: 10000,
    },
    {
      name: 'wd_cool',
      version_added: 10000,
    },
    {
      name: 'wd_cool_0.6M',
      version_added: 10000,
    },
    {
      name: 'wd_diffusion',
      version_added: 10000,
    },
    {
      name: 'wd_ignite',
      version_added: 10000,
    },
    {
      name: 'wd_surf_at_tau_1m4',
      version_added: 10000,
    }
  ]
)


users = User.create(
  {
    email: 'wmwolf@asu.edu',
    password: 'SunDevilsForTheWin',
    name: 'Bill Wolf',
    admin: true
  }
)

computers = Computer.create(
  [
    {
      name: 'euchre',
      user: User.where(name: 'Bill Wolf').first,
      platform: 'macOS',
      processor: '2.7GHz 12-Core Intel Xeon E5',
      ram_gb: 64
    },
    {
      name: 'rummy',
      user: User.where(name: 'Bill Wolf').first,
      platform: 'macOS',
      processor: '3.1GHz Intel Core i7',
      ram_gb: 16
    }
  ]
)

# populate test instances including a mix of the computers and test cases
# must also build test datum objects to include

####################################
#   instances of 1M_pre_ms_to_wd   #
####################################
# instance = TestInstance.create!(
#   runtime_seconds: 1500,
#   mesa_version: 10000,
#   omp_num_threads: 12,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: true,
#   test_case_id: test_cases[0].id,
#   computer_id: computers[0].id
# )
# instance.test_data.create(name: 'steps', integer_val: 24000)
# instance.test_data.create(name: 'retries', integer_val: 300)
# instance.test_data.create(name: 'backups', integer_val: 40)

# instance = TestInstance.create(
#   runtime_seconds: 2300,
#   mesa_version: 10000,
#   omp_num_threads: 4,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: true,
#   test_case_id: test_cases[0].id,
#   computer_id: computers[1].id
# )
# instance.test_data.create(name: 'steps', integer_val: 24000)
# instance.test_data.create(name: 'retries', integer_val: 300)
# instance.test_data.create(name: 'backups', integer_val: 40)
 
# #####################################
# #   instances of 15M_thermohaline   #
# #####################################
# instance = TestInstance.create(
#   runtime_seconds: 600,
#   mesa_version: 10000,
#   omp_num_threads: 12,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: false,
#   test_case_id: test_cases[1].id,
#   computer_id: computers[0].id
# )
# instance.test_data.create(name: 'steps', integer_val: 5000)
# instance.test_data.create(name: 'retries', integer_val: 30)
# instance.test_data.create(name: 'backups', integer_val: 4)

# ########################
# #   instances of wd2   #
# ########################
# instance = TestInstance.create(
#   runtime_seconds: 800,
#   mesa_version: 10000,
#   omp_num_threads: 12,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: true,
#   test_case_id: test_cases[2].id,
#   computer_id: computers[0].id
# )
# instance.test_data.create(name: 'steps', integer_val: 7000)
# instance.test_data.create(name: 'retries', integer_val: 100)
# instance.test_data.create(name: 'backups', integer_val: 20)

# instance = TestInstance.create(
#   runtime_seconds: 1200,
#   mesa_version: 10000,
#   omp_num_threads: 4,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: true,
#   test_case_id: test_cases[2].id,
#   computer_id: computers[1].id
# )
# instance.test_data.create(name: 'steps', integer_val: 7000)
# instance.test_data.create(name: 'retries', integer_val: 100)
# instance.test_data.create(name: 'backups', integer_val: 20)

# instance = TestInstance.create(
#   runtime_seconds: 900,
#   mesa_version: 10000,
#   omp_num_threads: 4,
#   compiler: 'ifort',
#   compiler_version: '17.0',
#   platform_version: '10.13',
#   passed: false,
#   test_case_id: test_cases[2].id,
#   computer_id: computers[2].id
# )
# instance.test_data.create(name: 'steps', integer_val: 7000)
# instance.test_data.create(name: 'retries', integer_val: 100)
# instance.test_data.create(name: 'backups', integer_val: 20)

# ##############################
# #   instances of wd_ignite   #
# ##############################
# instance = TestInstance.create(
#   runtime_seconds: 1200,
#   mesa_version: 10000,
#   omp_num_threads: 12,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: true,
#   test_case_id: test_cases[3].id,
#   computer_id: computers[0].id
# )
# instance.test_data.create(name: 'steps', integer_val: 9000)
# instance.test_data.create(name: 'retries', integer_val: 110)
# instance.test_data.create(name: 'backups', integer_val: 35)

# instance = TestInstance.create(
#   runtime_seconds: 2500,
#   mesa_version: 9795,
#   omp_num_threads: 12,
#   compiler: 'gfortran',
#   compiler_version: '7.2.0',
#   platform_version: '10.13',
#   passed: false,
#   test_case_id: test_cases[3].id,
#   computer_id: computers[0].id
# )
# instance.test_data.create(name: 'steps', integer_val: 800)
# instance.test_data.create(name: 'retries', integer_val: 1000)
# instance.test_data.create(name: 'backups', integer_val: 500)
