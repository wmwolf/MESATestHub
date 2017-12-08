class MorningMailer < ApplicationMailer
  include SendGrid

  def initialize
    @client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
  end

  def default_url_options
    if Rails.env.production?
      { host: 'https://testhub.mesastar.org' }
    elsif Rails.env.development?
      { host: 'http://localhost:3000' }
    else
      { host: 'http://localhost:3000' }
    end
  end

  def morning_email
    # first gather data from database; bail if there are no failure in the last
    # 24 hours
    @versions = TestInstance.failing_versions_since(1.day.ago)
    return if @versions.empty?
    @cases = {}
    @versions.each do |version|
      @cases[version] = TestInstance.failing_cases_since(1.day.ago, version)
    end
    # ornery links from SendGrid... doing this the hard way
    @version_links = {}
    @case_links = {}
    @cases.each do |version, cases|
      @version_links[version] = test_cases_url(version: version)
      @case_links[version] = {}
      cases.each do |test_case|
        @case_links[version][test_case] =
          test_case_url(test_case, version: version)
      end
    end

    # gather sender, recipient(s), subject, and body before composing email
    from = Email.new(email: 'noreply@testhub.mesastar.org',
                     name: 'MESA Test Hub')
    to = Email.new(email: 'mesa-developers@lists.mesastar.org')
    # to = Email.new(email: 'wmwolf@asu.edu', name: 'Bill Wolf')
    subject = "Failing tests in revision #{@versions.max}"
    subject += ' and others' if @versions.length > 1
    html_content = ApplicationController.render(
      template: 'morning_mailer/morning_email.html.erb',
      layout: 'mailer',
      assigns: { versions: @versions, cases: @cases, host: @host,
                 root_url: root_url, version_links: @version_links,
                 case_links: @case_links }
    )
    text_content = ApplicationController.render(
      template: 'morning_mailer/morning_email.text.erb',
      layout: 'mailer',
      assigns: { versions: @versions, cases: @cases, host: @host,
                 root_url: root_url, version_links: @version_links,
                 case_links: @case_links }
    )

    # compose e-mail
    email = Mail.new
    email.from = from
    email.subject = subject
    per = Personalization.new
    per.add_to(to)
    email.add_personalization(per)

    # due to SendGrid weirdness, plain text MUST come first or it won't send
    email.add_content(Content.new(type: 'text/plain', value: text_content))
    email.add_content(Content.new(type: 'text/html', value: html_content))

    # send the message
    @client.mail._('send').post(request_body: email.to_json)
  end
end
