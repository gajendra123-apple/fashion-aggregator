begin
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
  puts "✅ adminuser created"
rescue => e
  puts "❌ Failed to create admin user: #{e.message}"
end
