import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showhide"
export default class extends Controller {
  static targets = ["input", "inquiry", "product_issue", "billing", "order_issue", "account"]
  //static values = { showIf: String }
  static values = ["inquiry", "product_issue", "billing", "order_issue", "account"] 
  connect() {
    this.toggle()
  }

  toggle() {
    console.log(this.inputTarget.value)
    this.inquiryTarget.hidden = true
    this.product_issueTarget.hidden = true
    this.billingTarget.hidden = true
    this.order_issueTarget.hidden = true
    this.accountTarget.hidden = true


     if (this.inputTarget.value == "inquiry") {
      this.inquiryTarget.hidden = false

    } else if (this.inputTarget.value == "product_issue") {
       this.product_issueTarget.hidden = false

    } else if (this.inputTarget.value == "billing") {
       this.billingTarget.hidden = false

    } else if (this.inputTarget.value == "order_issue") {
       this.order_issueTarget.hidden = false

    } else if (this.inputTarget.value == "account") {
       this.accountTarget.hidden = false
    }
  }
}