import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "slide" ]
  static values = { index: Number }

  next() {
    this.indexValue++
    if(this.indexValue > 3){
      this.indexValue = 0
    }
  }

  previous() {
    this.indexValue--
    if(this.indexValue < 0){
      this.indexValue = 3
    }
  }

  indexValueChanged() {
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index != this.indexValue
    })
  }
}
