// Import and register all your controllers from the importmap via admin/controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("admin/controllers", application)
