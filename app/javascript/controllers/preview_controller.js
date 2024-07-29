import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    url: String
  };

  static targets = [
    "form"
  ];

  async update() {
    const form = new FormData(this.formTarget);

    form.delete("_method");

    const res = await fetch(this.urlValue, {
      method: "POST",

      headers: {
        "X-CSRF-Token": document.head.querySelector("[name=csrf-token]").content
      },

      body: form
    });

    Turbo.renderStreamMessage(await res.text());
  }
}
