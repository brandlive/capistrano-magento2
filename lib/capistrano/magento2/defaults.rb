##
 # Copyright © 2016 by David Alger. All rights reserved
 # 
 # Licensed under the Open Software License 3.0 (OSL-3.0)
 # See included LICENSE file for full text of OSL-3.0
 # 
 # http://davidalger.com/contact/
 ##

set :linked_files, fetch(:linked_files, []).push(
  'src/app/etc/env.php',
  'src/app/etc/config.local.php',
  'src/var/.setup_cronjob_status',
  'src/var/.update_cronjob_status',
  'src/pub/sitemap.xml'
)

set :linked_files_touch, fetch(:linked_files_touch, []).push(
  'src/app/etc/env.php',
  'src/app/etc/config.local.php',
  'src/var/.setup_cronjob_status',
  'src/var/.update_cronjob_status',
  'src/pub/sitemap.xml'
)

set :linked_dirs, fetch(:linked_dirs, []).push(
  'src/pub/media', 
  'src/pub/sitemaps',
  'src/pub/static',
  'src/var'
)

# magento composer repository auth credentials
set :magento_auth_repo_name, fetch(:magento_auth_repo_name, 'http-basic.repo.magento.com')
set :magento_auth_public_key, fetch(:magento_auth_public_key, false)
set :magento_auth_private_key, fetch(:magento_auth_private_key, false)

# deploy permissions defaults
set :magento_deploy_chmod_d, fetch(:magento_deploy_chmod_d, '2770')
set :magento_deploy_chmod_f, fetch(:magento_deploy_chmod_f, '0660')
set :magento_deploy_chmod_x, fetch(:magento_deploy_chmod_x, ['bin/magento'])

# deploy configuration defaults
set :magento_deploy_composer, fetch(:magento_deploy_composer, false)
set :magento_deploy_confirm, fetch(:magento_deploy_confirm, [])
set :magento_deploy_languages, fetch(:magento_deploy_languages, ['es_AR', 'en_US'])
set :magento_deploy_maintenance, fetch(:magento_deploy_maintenance, true)
set :magento_deploy_production, fetch(:magento_deploy_production, true)
set :magento_deploy_themes, fetch(:magento_deploy_themes, [])
set :magento_deploy_excludes_themes, fetch(:magento_deploy_excludes_themes, ['Magento/blank', 'Magento/luma'])
set :magento_deploy_areas, fetch(:magento_deploy_areas, [])
set :magento_deploy_static_content, fetch(:magento_deploy_static_content, false)
set :magento_remove_static_content, fetch(:magento_remove_static_content, false)
set :magento_di_compile, fetch(:magento_di_compile, false)
set :magento_deploy_jobs, fetch(:magento_deploy_jobs, nil)      # this defaults to 4 when supported by bin/magento
set :magento_deploy_strategy, fetch(:magento_deploy_strategy, nil)  # Magento 2.2 or later only: http://bit.ly/2yhMvVv


# deploy targetting defaults
set :magento_deploy_setup_role, fetch(:magento_deploy_setup_role, :all)
set :magento_deploy_cache_shared, fetch(:magento_deploy_cache_shared, true)

# pending deploy check defaults
set :magento_deploy_pending_role, fetch(:magento_deploy_pending_role, :all)
set :magento_deploy_pending_warn, fetch(:magento_deploy_pending_warn, true)
set :magento_deploy_pending_format, fetch(
  :magento_deploy_pending_format,
  '--pretty="format:%C(yellow)%h %Cblue%>(12)%ai %Cgreen%<(7)%aN%Cred%d %Creset%s"'
)



