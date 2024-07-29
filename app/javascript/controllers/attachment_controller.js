import { Controller } from '@hotwired/stimulus';
import { DirectUpload } from '@rails/activestorage';

export default class extends Controller {
  static values = {
    directUploadUrl: String,
    blobUrlTemplate: String
  };

  static targets = [
    'textarea'
  ];

  insertLink({target}) {
    for (const file of target.files) {
      const upload = new DirectUpload(file, this.directUploadUrlValue, {});

      upload.create((err, blob) => {
        if (err) {
          console.error(err);
          return;
        }

        const startPos = this.textareaTarget.selectionStart;
        const endPos   = this.textareaTarget.selectionEnd;
        const before   = this.textareaTarget.value.substring(0, startPos);
        const after    = this.textareaTarget.value.substring(endPos);
        const text     = this.#text(blob);

        this.textareaTarget.value          = before + text + after;
        this.textareaTarget.selectionStart = this.textareaTarget.selectionEnd = startPos + text.length;
        this.textareaTarget.focus();

        this.dispatch('linkInserted');
      });
    }
  }

  #text(blob) {
    const url = this.blobUrlTemplateValue.replace(':signed_id', blob.signed_id).replace(':filename', blob.filename);

    if (blob.content_type.startsWith('image/')) {
      return `![${blob.filename}](${url})`;
    } else {
      return `[${blob.filename}](${url})`;
    }
  }
}
