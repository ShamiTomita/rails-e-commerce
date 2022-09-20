import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["price", "quantity", "total", "remove"];
  connect() {
    console.log("hola mis amores are you ready to see my")
  }
  //purely cosmetic, a quick fix for now
  add(){
    //quantity
    let targetItem = this.quantityTarget.innerHTML
    let resultQuantity = parseInt(targetItem) + 1
    this.quantityTarget.innerHTML = resultQuantity;
    let unitPrice = this.priceTarget.dataset.price;
    let targetPrice = this.priceTarget.innerHTML
    let resultPrice = parseFloat(targetPrice) + parseFloat(unitPrice)
    this.priceTarget.innerHTML = resultPrice+'.0';
  }
  subtr(){
    let targetItem = this.quantityTarget.innerHTML
    let unitPrice = this.priceTarget.dataset.price;
    let targetPrice = this.priceTarget.innerHTML
    if(targetItem > 1){
      let resultQuantity = parseInt(targetItem) - 1
      this.quantityTarget.innerHTML = resultQuantity;
      let resultPrice = parseFloat(targetPrice) - parseFloat(unitPrice)
      this.priceTarget.innerHTML = resultPrice+'.0';
      }

  }

  changeTotal(){
    console.log(this.priceTarget)
  }

  removeItem(){
    console.log(this.removeTarget, this.priceTarget.innerHTML, this.totalTarget)
    let price = parseInt(this.priceTarget.innerHTML)
    let target = this.removeTarget
    target.style.display = "none"
    let emptyElement = document.createElement('div')
    emptyElement.dataset.price = "0.0"
    emptyElement.dataset.orderTarget = "price"
    emptyElement.innerHTML = ":3"
    target.parentNode.replaceChild(emptyElement, target);
  }
}
