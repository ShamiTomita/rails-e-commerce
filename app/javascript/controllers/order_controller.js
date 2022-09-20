import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order"
export default class extends Controller {
  static targets = ["price", "total_price", "remove"]
  connect() {
    console.log(this.priceTargets[0])
  }
  updateTotal(){
    let sum = 0
    this.priceTargets.forEach(item => sum += parseInt(item.innerHTML))
    console.log(sum)
    this.total_priceTarget.innerHTML = "Your Total: " + sum + ".0"
  }
  removeItem(){
    console.log(this.removeTarget, this.priceTarget.innerHTML, this.total_priceTarget)
    let price = parseInt(this.priceTarget.innerHTML)
    let target = this.removeTarget
    let emptyElement = document.createElement('div')
    emptyElement.style.display = "none"
    emptyElement.dataset.orderTarget = "price"
    emptyElement.innerHTML = "0"
    target.parentNode.replaceChild(emptyElement, target);

  }
}
