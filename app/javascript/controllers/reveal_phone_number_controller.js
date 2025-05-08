import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal-phone-number"
export default class extends Controller {
  static targets = ["phoneNumber"]

  connect() {
    console.log("hello world!")
  }

  reveal() {
    this.phoneNumberTarget.innerText = "booking.tool.user.phone_number"
  }
}
// if status == accepted
//  reveal phone number
// else
//  conceal phone number
// end
