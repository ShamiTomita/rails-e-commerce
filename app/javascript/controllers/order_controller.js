import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order"
export default class extends Controller {
  static targets = ["price", "total_price"]
  connect() {
    console.log(this.priceTargets[0])
  }
  updateTotal(){

    let sum = 0
    this.priceTargets.forEach(item => sum += parseInt(item.innerHTML))
    console.log(sum)
    this.total_priceTarget.innerHTML = "Your Total: " + sum + ".0"
  }
}
