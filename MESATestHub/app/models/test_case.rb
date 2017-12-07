class TestCase < ApplicationRecord
  has_many :test_instances, dependent: :destroy
  has_many :computers, through: :test_instances

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_inclusion_of :datum_1_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_2_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_3_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_4_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_5_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_6_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_7_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_8_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_9_type, in: %w[integer float string boolean],
                                        allow_blank: true
  validates_inclusion_of :datum_10_type, in: %w[integer float string boolean],
                                         allow_blank: true

  def self.modules
    %w[star binary]
  end

  validates_inclusion_of :module, in: TestCase.modules, allow_blank: true

  def self.versions
    TestInstance.versions
  end

  def self.find_by_version(version = :all)
    return TestCase.all.order(:name) if version.to_s.to_sym == :all
    search_version = version == :latest ? versions.max : version
    # TestInstance is indexed on mesa version, so we get those in constant
    # time, then back out unique Test Cases. This is usually used to get
    # data for index, so eagerly load instances to get at status without
    # hitting database for a ton more queries
    TestCase.includes(:test_instances).find(
      TestInstance.where(
        mesa_version: search_version
      ).pluck(:test_case_id).uniq
    ).sort { |a, b| (a.name <=> b.name) }
  end

  def self.version_statistics(test_cases, version)
    stats = { passing: 0, mixed: 0, failing: 0 }
    test_cases.each do |test_case|
      case test_case.version_status(version)
      when 0 then stats[:passing] += 1
      when 1 then stats[:failing] += 1
      when 2 then stats[:mixed] += 1
      end
    end
    stats
  end

  def self.version_computer_specs(test_cases, version)
    specs = {}
    find_by_version
    test_cases.each do |test_case|
      test_case.version_instances(version).each do |instance|
        spec = instance.computer_specification
        specs[spec] = [] unless specs.include?(spec)
        specs[spec] << instance.computer.name
      end
    end
    specs.each_value(&:uniq!)
    specs
  end

  # list of version numbers with test instances that have failed since a
  # particular date (handled by TestInstance... unclear where this should live)
  def failing_versions_since(date)
    TestInstance.failing_versions_since(date)
  end

  # list of test cases with instances that failed for a particular version
  # since a particular date (handled by TestInstance... unclear where this 
  # should live)
  def failing_cases_since(date, version)
    TestInstance.failing_cases_since(date, version)
  end

  # this is ugly and hard-codey, but what're ya gonna do?
  def data_names
    [datum_1_name, datum_2_name, datum_3_name, datum_4_name,
     datum_5_name, datum_6_name, datum_7_name, datum_8_name, datum_9_name,
     datum_10_name].reject { |name| name.nil? || name.strip.empty? }
  end

  def data_types
    [datum_1_type, datum_2_type, datum_3_type, datum_4_type,
     datum_5_type, datum_6_type, datum_7_type, datum_8_type, datum_9_type,
     datum_10_type].reject { |type| type.nil? || type.strip.empty? }
  end

  # assumes the user put in matching data names and types (i.e. datum_1_name
  # ALWAYS has a corresponding datum_1_type and there are no orphans). This
  # should be handled by a validation
  def data_type(data_name)
    return nil unless data_names.include? data_name
    Hash[data_names.zip data_types][data_name]
  end

  def last_tested
    return test_instances.maximum(:created_at) unless test_instances.loaded?
    test_instances.map(&:created_at).max
  end

  alias last_tested_date last_tested

  def last_test_status
    return 3 if test_instances.empty?
    test_instances.where(created_at: last_tested_date).first.passed ? 0 : 1
  end

  def mesa_versions
    test_instances.pluck(:mesa_version).uniq.sort.reverse
  end

  def version_instances(version)
    return test_instances if version == :all
    # hit the database directly if needed
    unless test_instances.loaded?
      return test_instances.where(mesa_version: version)
                           .order(created_at: :desc)
    end
    # instances already loaded? avoid hitting the database
    test_instances.select { |t| t.mesa_version == version }
                  .sort do |a, b|
                    -(a.created_at <=> b.created_at)
                  end
  end

  def version_status(version)
    return last_version_status if version == :all
    these_instances = version_instances(version)
    return 3 if these_instances.empty?
    passing_count = 0
    failing_count = 0
    if test_instances.loaded?
      passing_count = these_instances.select(&:passed).length
      failing_count = these_instances.reject(&:passed).length
    else
      passing_count = these_instances.where(passed: true).count
      failing_count = these_instances.where(passed: false).count
    end
    # success by default if we have at least one instance and no failures
    return 0 unless failing_count > 0
    # at least one failing, if also one passing, send back 2 (mixed). Otherwise
    # send back 1 (failing)
    passing_count > 0 ? 2 : 1
  end

  def version_computers_count(version)
    unless test_instances.loaded?
      return version_instances(version).pluck(:computer_id).uniq.length
    end
    version_instances(version).map(&:computer_id).uniq.length
  end

  def last_version
    return test_instances.maximum(:mesa_version) unless test_instances.loaded?
    test_instances.map(&:mesa_version).max
  end

  def last_version_status
    version_status(last_version)
  end
end
