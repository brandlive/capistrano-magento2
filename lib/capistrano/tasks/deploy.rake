##
 # Copyright © 2016 by David Alger. All rights reserved
 # 
 # Licensed under the Open Software License 3.0 (OSL-3.0)
 # See included LICENSE file for full text of OSL-3.0
 # 
 # http://davidalger.com/contact/
 ##

include Capistrano::Magento2::Helpers

namespace :deploy do
  before 'deploy:check:linked_files', 'magento:deploy:check'

  before :starting, :confirm_action do
    if fetch(:magento_deploy_confirm).include? fetch(:stage).to_s
      print "\e[0;31m      Are you sure you want to deploy to #{fetch(:stage).to_s}? [y/n] \e[0m"
      proceed = STDIN.gets[0..0] rescue nil
      exit unless proceed == 'y' || proceed == 'Y'
    end
  end

  task :updated do
    invoke 'magento:deploy:verify'
    invoke 'magento:composer:install' if fetch(:magento_deploy_composer)
    invoke 'magento:setup:permissions'

    invoke 'magento:setup:static-content:remove' if fetch(:magento_remove_static_content)
    invoke 'magento:setup:static-content:remove_preprocessed' if fetch(:magento_remove_static_preprocessed)
    invoke 'magento:setup:static-content:deploy' if fetch(:magento_deploy_static_content)
    invoke 'magento:setup:di:compile' if fetch(:magento_di_compile)
    
    invoke 'magento:setup:permissions'
    invoke 'magento:maintenance:enable' if fetch(:magento_deploy_maintenance)

    on release_roles :all do
      if test "[ -f #{current_path}/src/bin/magento ]"
        within current_path do
          execute :magento, 'maintenance:enable' if fetch(:magento_deploy_maintenance)
        end
      end
    end

    invoke 'magento:setup:db:schema:upgrade'
    invoke 'magento:setup:db:data:upgrade'

    on primary fetch(:magento_deploy_setup_role) do
      within release_path do
        _disabled_modules = disabled_modules
        if _disabled_modules.count > 0
          info "\nThe following modules are disabled per app/etc/config.php:\n"
          _disabled_modules.each do |module_name|
            info '- ' + module_name
          end
        end
      end
    end
  end

  task :published do
    invoke 'magento:cache:flush'
    invoke 'magento:cache:varnish:ban'
    invoke 'magento:maintenance:disable' if fetch(:magento_deploy_maintenance)
  end
end
