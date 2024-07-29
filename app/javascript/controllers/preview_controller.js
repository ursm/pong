import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    url: String
  };

  static targets = [
    "form",
    "frame"
  ];

  connect() {
    this.update();
  }

  update() {
    const formData = new FormData(this.formTarget);
    const params   = new URLSearchParams(formData);
    const url      = new URL(this.urlValue, location.origin);

    url.search = params;

    this.frameTarget.src = url;
    this.frameTarget.reload();
  }
}
