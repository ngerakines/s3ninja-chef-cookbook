name             's3ninja'
maintainer       'Nick Gerakines'
maintainer_email 'nick@gerakines.net'
license          'All rights reserved'
description      'Installs/Configures s3ninja'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "yum", "~> 3.2.0"
depends "apt", "~> 2.3.10"
depends "java", "~> 1.22.0"