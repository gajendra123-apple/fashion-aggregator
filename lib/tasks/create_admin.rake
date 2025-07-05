namespace :admin do
  desc "Create an AdminUser"
  task create: :environment do
    AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
      user.password = 'password'
      user.password_confirmation = 'password'
    end
    puts "✅ AdminUser created"
  end
end
