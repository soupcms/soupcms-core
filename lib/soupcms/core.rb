require 'soupcms/core/version'
require 'soupcms/common'

require 'soupcms/core/utils/params_hash'
require 'soupcms/core/utils/render_partials'
require 'soupcms/core/utils/http_client'

require 'soupcms/core/controller/page_controller'
require 'soupcms/core/controller/model_controller'

begin
  require 'nokogiri'
  require 'soupcms/core/processor/nokogiri_toc'
rescue LoadError
  puts "To load nokogiri_toc add gems 'nokogiri'"
end

require 'soupcms/core/template/manager'
require 'soupcms/core/template/file_store'
require 'soupcms/core/template/soupcms_api_store'

require 'soupcms/core/model/responsive_image'
require 'soupcms/core/model/simple_image'
require 'soupcms/core/model/cloudinary_responsive_image'
require 'soupcms/core/model/cdnconnect_responsive_image'

require 'soupcms/core/model/document'
require 'soupcms/core/model/page'
require 'soupcms/core/model/page_area'
require 'soupcms/core/model/page_module'
require 'soupcms/core/model/page_layout'
require 'soupcms/core/model/module_recipe'
require 'soupcms/core/model/module_template'

require 'soupcms/core/recipe/inline'
require 'soupcms/core/recipe/http'
require 'soupcms/core/recipe/soupcms_api'
require 'soupcms/core/recipe/post_processor'

require 'soupcms/core/utils/config'

require 'soupcms/core/api/base'
require 'soupcms/core/api/service'

require 'soupcms/soupcms_rack_app'
require 'soupcms/soupcms_core'
