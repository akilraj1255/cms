# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  site_id    :integer          not null
#  subject    :string(64)       not null
#  name       :string(64)       not null
#  email      :string(64)       not null
#  phone      :string(32)
#  delivered  :boolean          default(FALSE), not null
#  message    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_messages_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_c1eba9fee4  (site_id => sites.id)
#

FactoryGirl.define do
  factory :message do
    site
    subject { Faker::Name.name }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { "+447#{rand(1_000_000_000).to_s.ljust(9, '0')}" }
    message { Faker::Lorem.paragraph }
  end
end