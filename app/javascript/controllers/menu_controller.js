import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "toggleable" ]
  connect(){
    this.toggleableTarget.classList.toggle('hidden')
  }
  toggle() {
       this.toggleableTarget.classList.toggle('hidden')
    }
}
