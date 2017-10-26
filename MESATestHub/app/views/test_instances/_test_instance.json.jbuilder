json.extract! test_instance, :id, :runtime_seconds, :mesa_version, :omp_num_threads, :compiler, :compiler_version, :platform_version, :passed, :created_at, :updated_at
json.url test_case_test_instance_url(@test_case, test_instance, format: :json)
