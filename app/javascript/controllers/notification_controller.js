import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.element.remove()
    }, 4000)
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }
}