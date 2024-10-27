pin "application"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "admin", preload: false
pin_all_from "app/javascript/admin/controllers", under: "admin/controllers", preload: false

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"

pin "@rails/activestorage", to: "@rails--activestorage.js", preload: false # @7.1.3
pin "autosize", preload: false # @6.0.1
pin "stimulus-use", preload: false # @0.52.2
