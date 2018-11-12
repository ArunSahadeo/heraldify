$LOAD_PATH.push File.expand_path('../../app', __FILE__)

require 'models/user'
require 'models/role'
require 'models/user_role'

admin_users = [
    {
      'username': 'admin1',
      'password': ENV['ADMIN_1_PASSWORD'],
      'first_name': 'Admin',
      'last_name': '1',
      'email': 'admin1@example.com'
    },
    {
      'username': 'admin2',
      'password': ENV['ADMIN_2_PASSWORD'],
      'first_name': 'John',
      'last_name': 'Smith',
      'email': 'admin2@example.com'
    } 
]

roles = [
    {
        'name': 'admin'
    },
    {
        'name': 'editor'
    }
]

roles.each do |role|
    next if Role.where(name: role[:name]).exists?

    new_role = Role.new
    new_role.name = role[:name]
    new_role.save!

    puts "A role called '#{new_role.name}' has been created."
end

admin_users.each do |admin_user|

    next if User.where(username: admin_user[:username], first_name: admin_user[:first_name], last_name: admin_user[:last_name], email: admin_user[:email]).exists?

    new_admin = User.new
    new_admin.username = admin_user[:username]
    new_admin.password = admin_user[:password]
    new_admin.first_name = admin_user[:first_name]
    new_admin.last_name = admin_user[:last_name]
    new_admin.email = admin_user[:email]
    new_admin.save!

    puts "User #{new_admin.id} has been created."

    admin_role = Role.find_by name: 'admin'
    user_role = UserRole.new
    user_role.user_id = new_admin.id
    user_role.role_id = admin_role.id
    user_role.save!
end
