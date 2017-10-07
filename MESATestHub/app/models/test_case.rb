class TestCase < ApplicationRecord
  has_many :test_instances, after_add: :update_test_status
  has_many :computers, through: :test_instances

  # this is ugly and hard-codey, but what're ya gonna do?
  def data_names
    [datum_1_name, datum_2_name, datum_3_name, datum_4_name,
     datum_5_name, datum_6_name, datum_7_name, datum_8_name, datum_9_name, 
     datum_10_name].reject { |name| name.nil? or name.strip.empty? }
  end

  def data_types
    [datum_1_type, datum_2_type, datum_3_type, datum_4_type,
     datum_5_type, datum_6_type, datum_7_type, datum_8_type, datum_9_type, 
     datum_10_type].reject { |type| type.nil? or type.strip.empty? }
  end


  # assumes the user put in matching data names and types (i.e. datum_1_name
  # ALWAYS has a corresponding datum_1_type and there are no orphans). This
  # should be handled by a validation
  def data_type(data_name)
    return nil unless data_names.include? data_name
    return Hash[data_names.zip data_types][data_name]
  end

  def current_last_tested
    test_instances.maximum(:created_at)
  end


  def update_test_status(test_instance)

    # easily refer to the test case that just had a test instance added
    test_case = test_instance.test_case

    # update the last tested date to the most recent test (may not be this
    # one if it is added after the fact)
    if not test_instance.created_at.nil?
      if test_case.current_last_tested.nil?
        test_case.last_tested = test_instance.created_at
      else
        test_case.last_tested = [test_instance.created_at,
         test_case.current_last_tested].maximum
      end
    end
    # test_case.last_tested = TestInstance.where(test_case_id: test_case.id).maximum(:created_at)
    # test_case.last_tested ||= test_case.test_instances.maximum("created_at").created_at
    # test_case.last_tested = TestInstance.first.created_at

    # set the last test result
    test_case.last_test_status = test_instance.passed ? 0 : 1

    if not test_instance.mesa_version.nil?
      if test_instance.mesa_version == test_case.last_version
        # new test of the most current version; update passage status
        if test_case.last_version_status == 0
          # all previous tests passed (status 0), so if this passes, keep it
          # at passing. Otherwise switch to mixed (status 2)
          test_case.last_version_status = 2 unless test_instance.passed

        elsif test_case.last_version_status == 1
          # all previous tests failed (status 1), so if this fails, keep it
          # at failing. Otherwise, switch to mixed (status 2)
          test_case.last_version_status = 2 if test_instance.passed
        end

      elsif test_case.last_version.nil? or 
        test_case.last_version < test_instance.mesa_version
        # this is the first test of this newest version, update the last
        # version
        test_case.last_version = test_instance.mesa_version
        # update passage status to passing or failing since this is the
        # first test of this version
        test_case.last_version_status = test_instance.passed ? 0 : 1
      end        
    end
    test_case.save
  end

end
