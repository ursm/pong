pin "application"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "admin", preload: false
pin_all_from "app/javascript/admin/controllers", under: "admin/controllers", preload: false

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"

pin "@avo-hq/marksmith", to: "@avo-hq--marksmith.js", preload: false # @0.2.1
pin "@rails/activestorage", to: "@rails--activestorage.js", preload: false # @8.0.0
pin "stimulus-use", preload: false # @0.52.2
