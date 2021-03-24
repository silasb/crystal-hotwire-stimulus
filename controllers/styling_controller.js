import { Controller} from "stimulus"

export default class extends Controller {
  static targets = ["button"]
  static classes = ["primary"]

  connect() {
    this.buttonTarget.classList.add(this.primaryClass)
  }

  clicked() {
    this.buttonTarget.classList.toggle(this.primaryClass)
  }
}