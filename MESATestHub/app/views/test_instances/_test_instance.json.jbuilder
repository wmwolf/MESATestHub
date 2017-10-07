json.extract! test_instance, :id, :start, :finish, :runtime_seconds, :mesa_version, :omp_num_threads, :compiler, :compiler_version, :platform_version, :passed, :computer_id, :test_case_id, :created_at, :updated_at
json.url test_instance_url(test_instance, format: :json)
